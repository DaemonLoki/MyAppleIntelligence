//
//  AttentionVariant.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 10.11.24.
//

import CoreML

enum AttentionVariant: String {
    case original
    case splitEinsum
    case splitEinsumV2
}

extension AttentionVariant {
    var defaultComputeUnits: MLComputeUnits { self == .original ? .cpuAndGPU : .cpuAndNeuralEngine }
}
