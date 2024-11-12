//
//  ModelInfo.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 10.11.24.
//

import CoreML

struct ModelInfo {
    /// Hugging Face model Id that contains .zip archives with compiled Core ML models
    let modelId: String
    
    /// Arbitrary string for presentation purposes. Something like "2.1-base"
    let modelVersion: String
    
    /// Suffix of the archive containing the ORIGINAL attention variant. Usually something like "original_compiled"
    let originalAttentionSuffix: String

    /// Suffix of the archive containing the SPLIT_EINSUM attention variant. Usually something like "split_einsum_compiled"
    let splitAttentionSuffix: String
    
    /// Suffix of the archive containing the SPLIT_EINSUM_V2 attention variant. Usually something like "split_einsum_v2_compiled"
    let splitAttentionV2Suffix: String

    /// Whether the archive contains ANE optimized models
    let supportsNeuralEngine: Bool

    /// Whether the archive contains the VAE Encoder (for image to image tasks). Not yet in use.
    let supportsEncoder: Bool
    
    /// Is attention v2 supported? (Ideally, we should know by looking at the repo contents)
    let supportsAttentionV2: Bool
    
    /// Are weights quantized? This is only used to decide whether to use `reduceMemory`
    let quantized: Bool
    
    /// Whether this is a Stable Diffusion XL model
    // TODO: retrieve from remote config
    let isXL: Bool

    /// Whether this is a Stable Diffusion 3 model
    // TODO: retrieve from remote config
    let isSD3: Bool

    //TODO: refactor all these properties
    init(modelId: String, modelVersion: String,
         originalAttentionSuffix: String = "original_compiled",
         splitAttentionSuffix: String = "split_einsum_compiled",
         splitAttentionV2Suffix: String = "split_einsum_v2_compiled",
         supportsNeuralEngine: Bool = true,
         supportsEncoder: Bool = false,
         supportsAttentionV2: Bool = false,
         quantized: Bool = false,
         isXL: Bool = false,
         isSD3: Bool = false) {
        self.modelId = modelId
        self.modelVersion = modelVersion
        self.originalAttentionSuffix = originalAttentionSuffix
        self.splitAttentionSuffix = splitAttentionSuffix
        self.splitAttentionV2Suffix = splitAttentionV2Suffix
        self.supportsNeuralEngine = supportsNeuralEngine
        self.supportsEncoder = supportsEncoder
        self.supportsAttentionV2 = supportsAttentionV2
        self.quantized = quantized
        self.isXL = isXL
        self.isSD3 = isSD3
    }
}

extension ModelInfo {
    //TODO: set compute units instead and derive variant from it
    static var defaultAttention: AttentionVariant {
        return .splitEinsum
    }
    
    static var defaultComputeUnits: MLComputeUnits { defaultAttention.defaultComputeUnits }
    
    var bestAttention: AttentionVariant {
        if supportsAttentionV2 { return .splitEinsumV2 }
        return ModelInfo.defaultAttention
    }
    var defaultComputeUnits: MLComputeUnits { bestAttention.defaultComputeUnits }
    
    func modelURL(for variant: AttentionVariant) -> URL {
        // Pattern: https://huggingface.co/pcuenq/coreml-stable-diffusion/resolve/main/coreml-stable-diffusion-v1-5_original_compiled.zip
        let suffix: String
        switch variant {
        case .original: suffix = originalAttentionSuffix
        case .splitEinsum: suffix = splitAttentionSuffix
        case .splitEinsumV2: suffix = splitAttentionV2Suffix
        }
        let repo = modelId.split(separator: "/").last!
        return URL(string: "https://huggingface.co/\(modelId)/resolve/main/\(repo)_\(suffix).zip")!
    }
    
    /// Best variant for the current platform.
    /// Currently using `split_einsum` for iOS and simple performance heuristics for macOS.
    var bestURL: URL { modelURL(for: bestAttention) }
    
    var reduceMemory: Bool {
        // Enable on iOS devices, except when using quantization
        if isXL { return !deviceHas8GBOrMore }
        return !(quantized && deviceHas6GBOrMore)
    }
}

let deviceHas6GBOrMore = ProcessInfo.processInfo.physicalMemory > 5910000000   // Reported by iOS 17 beta (21A5319a) on iPhone 13 Pro: 5917753344
let deviceHas8GBOrMore = ProcessInfo.processInfo.physicalMemory > 7900000000   // Reported by iOS 17.0.2 on iPhone 15 Pro Max: 8021032960

extension ModelInfo {
    static let v21Base = ModelInfo(
        modelId: "pcuenq/coreml-stable-diffusion-2-1-base",
        modelVersion: "StabilityAI SD 2.1",
        supportsEncoder: true
    )
    
    static let xlmbpChunked = ModelInfo(
        modelId: "apple/coreml-stable-diffusion-xl-base-ios",
        modelVersion: "SDXL base (768, iOS) [4 bit]",
        supportsEncoder: false,
        quantized: true,
        isXL: true
    )
    
    static let v21Palettized = ModelInfo(
        modelId: "apple/coreml-stable-diffusion-2-1-base-palettized",
        modelVersion: "StabilityAI SD 2.1 [6 bit]",
        supportsEncoder: true,
        supportsAttentionV2: true,
        quantized: true
    )
    
    static let MODELS: [ModelInfo] = {
        var models = [ModelInfo.v21Base, ModelInfo.v21Palettized]
        
        if deviceSupportsQuantization {
            models.append(ModelInfo.xlmbpChunked)
        }
        
        return models
    }()
    
    static func from(modelVersion: String) -> ModelInfo? {
        ModelInfo.MODELS.first(where: {$0.modelVersion == modelVersion})
    }
    
    static func from(modelId: String) -> ModelInfo? {
        ModelInfo.MODELS.first(where: {$0.modelId == modelId})
    }
}

let deviceSupportsQuantization = {
    if #available(iOS 17, *) {
        true
    } else {
        false
    }
}()

