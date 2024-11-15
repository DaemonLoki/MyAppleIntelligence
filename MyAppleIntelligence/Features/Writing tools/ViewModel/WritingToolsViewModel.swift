//
//  WritingToolsViewModel.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 09.11.24.
//

import MLX
import MLXRandom
import MarkdownUI
import Metal
import SwiftUI
import Tokenizers

@MainActor
class WritingToolsViewModel: ObservableObject {
    
    @Published var textInput = "The bestest TV show I've ever had wathed was The Game of Thrones seres. It ws s gdd!"
    @Published var analyzingText = false
    @Published var showingWritingTools = false
    @Published var startDate: Date = Date()
    
    var running = false
    
    var output = ""
    var modelInfo = ""
    
    let systemPrompt = "You are a professional writing assistant designed to improve and transform written text according to user needs. Your goal is to make text clearer, more concise, and appropriate in tone or format based on the user's instructions. You handle text with precision, ensuring accurate grammar, a clear message, and the specified tone or structure. Respond only with the improved or transformed text unless otherwise requested."
    
    /// This controls which model loads. `llama3_2_3B_4bit` is one of the smaller ones, so this will fit on
    /// more devices.
    let modelConfiguration = ModelConfiguration.llama3_2_3B_4bit
    
    /// parameters controlling the output
    let generateParameters = GenerateParameters(temperature: 0.6)
    let maxTokens = 240
    
    /// update the display every N tokens -- 4 looks like it updates continuously
    /// and is low overhead.  observed ~15% reduction in tokens/s when updating
    /// on every token
    let displayEveryNTokens = 4
    
    enum LoadState {
        case idle
        case loaded(ModelContainer)
    }
    
    var loadState = LoadState.idle
    
    /// load and return the model -- can be called multiple times, subsequent calls will
    /// just return the loaded model
    func load() async throws -> ModelContainer {
        switch loadState {
        case .idle:
            // limit the buffer cache
            MLX.GPU.set(cacheLimit: 20 * 1024 * 1024)
            
            let modelContainer = try await loadModelContainer(configuration: modelConfiguration)
            {
                [modelConfiguration] progress in
                Task { @MainActor in
                    self.modelInfo =
                    "Downloading \(modelConfiguration.name): \(Int(progress.fractionCompleted * 100))%"
                    
                    print("Downloading \(modelConfiguration.name): \(Int(progress.fractionCompleted * 100))%")
                }
            }
            let numParams = await modelContainer.perform {
                [] model, _ in
                return model.numParameters()
            }
            
            self.modelInfo =
            "Loaded \(modelConfiguration.id).  Weights: \(numParams / (1024*1024))M"
            loadState = .loaded(modelContainer)
            return modelContainer
            
        case .loaded(let modelContainer):
            return modelContainer
        }
    }
    
    func executeLLM(with option: WritingToolOption) {
        Task {
            await generateText(text: textInput, option: option)
        }
    }
    
    private func generateText(text: String, option: WritingToolOption) async {
        guard !running else { return }
        
        self.startDate = Date()
        self.showingWritingTools = false
        
        withAnimation {
            analyzingText = true
        }
        
        try? await Task.sleep(for: .seconds(2))
        
        withAnimation {
            analyzingText = false
        }
        
        
        running = true
        textInput = ""
        
        do {
            let modelContainer = try await load()
            
            let messages = [
                ["role": "system", "content": systemPrompt],
                ["role": "user", "content": option.generatePrompt(with: text)]
            ]
            let promptTokens = try await modelContainer.perform { _, tokenizer in
                try tokenizer.applyChatTemplate(messages: messages)
            }
            
            // each time you generate you will get something new
            MLXRandom.seed(UInt64(Date.timeIntervalSinceReferenceDate * 1000))
            
            let result = await modelContainer.perform { model, tokenizer in
                MyAppleIntelligence.generate(
                    promptTokens: promptTokens, parameters: generateParameters, model: model,
                    tokenizer: tokenizer, extraEOSTokens: modelConfiguration.extraEOSTokens
                ) { tokens in
                    // update the output -- this will make the view show the text as it generates
                    if tokens.count % displayEveryNTokens == 0 {
                        let text = tokenizer.decode(tokens: tokens)
                        Task { @MainActor in
                            self.textInput = text
                        }
                    }
                    
                    if tokens.count >= maxTokens {
                        return .stop
                    } else {
                        return .more
                    }
                }
            }
            
            // update the text if needed, e.g. we haven't displayed because of displayEveryNTokens
            if result.output != self.output {
                self.output = result.output
            }

            print("Tokens/second: \(String(format: "%.3f", result.tokensPerSecond))")
            
        } catch {
            textInput = "Failed: \(error)"
        }
        
        running = false
    }
}
