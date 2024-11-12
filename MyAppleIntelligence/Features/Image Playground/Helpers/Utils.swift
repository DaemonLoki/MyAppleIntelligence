//
//  Utils.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 10.11.24.
//

import Foundation

//extension String: Error {}

/// Returns an array of booleans that indicates at which steps a preview should be generated.
///
/// - Parameters:
///   - numInferenceSteps: The total number of inference steps.
///   - numPreviews: The desired number of previews.
///
/// - Returns: An array of booleans of size `numInferenceSteps`, where `true` values represent steps at which a preview should be made.
func previewIndices(_ numInferenceSteps: Int, _ numPreviews: Int) -> [Bool] {
    // Ensure valid parameters
    guard numInferenceSteps > 0, numPreviews > 0 else {
        return [Bool](repeating: false, count: numInferenceSteps)
    }

    // Compute the ideal (floating-point) step size, which represents the average number of steps between previews
    let idealStep = Double(numInferenceSteps) / Double(numPreviews)

    // Compute the actual steps at which previews should be made. For each preview, we multiply the ideal step size by the preview number, and round to the nearest integer.
    // The result is converted to a `Set` for fast membership tests.
    let previewIndices: Set<Int> = Set((0..<numPreviews).map { previewIndex in
        return Int(round(Double(previewIndex) * idealStep))
    })
    
    // Construct an array of booleans where each value indicates whether or not a preview should be made at that step.
    let previewArray = (0..<numInferenceSteps).map { previewIndices.contains($0) }

    return previewArray
}
