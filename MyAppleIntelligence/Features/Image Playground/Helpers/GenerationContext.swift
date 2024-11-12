//
//  GenerationContext.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 10.11.24.
//

import SwiftUI
import Combine

class GenerationContext: ObservableObject {
    let scheduler = StableDiffusionScheduler.dpmSolverMultistepScheduler

    @Published var pipeline: Pipeline? = nil {
        didSet {
            if let pipeline = pipeline {
                progressSubscriber = pipeline
                    .progressPublisher
                    .receive(on: DispatchQueue.main)
                    .sink { progress in
                        guard let progress = progress else { return }
                        self.updatePreviewIfNeeded(progress)
                        self.state = .running(progress)
                    }
            }
        }
    }
    @Published var state: GenerationState = .startup
    
    @Published var positivePrompt = Settings.shared.prompt
    @Published var negativePrompt = Settings.shared.negativePrompt

    // FIXME: Double to support the slider component
    @Published var steps: Double = Settings.shared.stepCount
    @Published var numImages: Double = 1.0
    @Published var seed: UInt32 = Settings.shared.seed
    @Published var guidanceScale: Double = Settings.shared.guidanceScale
    @Published var previews: Double = 0.0
    @Published var disableSafety = false
    @Published var previewImage: CGImage? = nil

    @Published var computeUnits: ComputeUnits = Settings.shared.userSelectedComputeUnits ?? ModelInfo.defaultComputeUnits

    private var progressSubscriber: Cancellable?

    private func updatePreviewIfNeeded(_ progress: StableDiffusionProgress) {
        if previews == 0 || progress.step == 0 {
            previewImage = nil
        }

        if previews > 0, let newImage = progress.currentImages.first, newImage != nil {
            previewImage = newImage
        }
    }

    func generate(prompt: String) async throws -> GenerationResult {
        guard let pipeline = pipeline else { throw "No pipeline" }
        return try pipeline.generate(
            prompt: prompt,
            negativePrompt: negativePrompt,
            scheduler: scheduler,
            numInferenceSteps: Int(steps),
            seed: seed,
            numPreviews: Int(previews),
            guidanceScale: Float(guidanceScale),
            disableSafety: disableSafety
        )
    }
    
    func cancelGeneration() {
        pipeline?.setCancelled()
    }
}
