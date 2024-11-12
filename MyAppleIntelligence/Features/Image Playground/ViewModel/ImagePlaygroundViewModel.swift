//
//  ImagePlaygroundViewModel.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 06.11.24.
//

import SwiftUI
import Combine

enum CurrentView: Equatable {
    case loading
    case ready
    case error(String)
}

enum PreparationPhase: String {
    case Downloading, Uncompressing, Loading
}

@MainActor
class ImagePlaygroundViewModel: ObservableObject {
    var generation = GenerationContext()
    
    @Published var currentView: CurrentView = .loading
    @Published var imageName: String?
    @Published var generating = false
    
    @Published var generatedImage: CGImage?
    
    @Published var preparationPhase: PreparationPhase = .Downloading
    @Published var downloadProgress: Double = 0
    
    @Published var stateSubscriber: Cancellable?
    
    func generate(prompt: String) {
        self.generatedImage = nil
        if case .running = generation.state { return }

        generating = true
        generation.positivePrompt = prompt
        Task {
            generation.state = .running(nil)
            do {
                let result = try await generation.generate(prompt: prompt)
                generation.state = .complete(generation.positivePrompt, result.image, result.lastSeed, result.interval)
                
                await MainActor.run {
                    self.generatedImage = result.image
                }
            } catch {
                generation.state = .failed(error)
                generating = false
            }
        }
    }
    
    func loadModel() async {
        let loader = PipelineLoader(model: iosModel())
        stateSubscriber = loader.statePublisher.sink { state in
            DispatchQueue.main.async {
                switch state {
                case .downloading(let progress):
                    self.preparationPhase = .Downloading
                    self.downloadProgress = progress
                case .uncompressing:
                    self.preparationPhase = .Uncompressing
                    self.downloadProgress = 1
                case .readyOnDisk:
                    self.preparationPhase = .Loading
                    self.downloadProgress = 1
                default:
                    break
                }
            }
        }
        do {
            generation.pipeline = try await loader.prepare()
            self.currentView = .ready
        } catch {
            self.currentView = .error("Could not load model, error: \(error)")
        }
    }
    
    func iosModel() -> ModelInfo {
        guard deviceSupportsQuantization else { return ModelInfo.v21Base }
        if deviceHas6GBOrMore { return ModelInfo.xlmbpChunked }
        return ModelInfo.v21Palettized
    }

}
