//
//  State.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 10.11.24.
//

import Combine
import SwiftUI
import StableDiffusion
import CoreML

/// Schedulers compatible with StableDiffusionPipeline. This is a local implementation of the StableDiffusionScheduler enum as a String represetation to allow for compliance with NSSecureCoding.
public enum StableDiffusionScheduler: String {
    /// Scheduler that uses a pseudo-linear multi-step (PLMS) method
    case pndmScheduler
    /// Scheduler that uses a second order DPM-Solver++ algorithm
    case dpmSolverMultistepScheduler
    /// Scheduler for rectified flow based multimodal diffusion transformer models
//    case discreteFlowScheduler

    func asStableDiffusionScheduler() -> StableDiffusion.StableDiffusionScheduler {
        switch self {
        case .pndmScheduler: return StableDiffusion.StableDiffusionScheduler.pndmScheduler
        case .dpmSolverMultistepScheduler: return StableDiffusion.StableDiffusionScheduler.dpmSolverMultistepScheduler
//        case .discreteFlowScheduler: return StableDiffusion.StableDiffusionScheduler.discreteFlowScheduler
        }
    }
}
