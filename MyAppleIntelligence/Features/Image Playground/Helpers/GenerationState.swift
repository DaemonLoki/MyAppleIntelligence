//
//  GenerationState.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 10.11.24.
//

import StableDiffusion
import SwiftUI

enum GenerationState {
    case startup
    case running(StableDiffusionProgress?)
    case complete(String, CGImage?, UInt32, TimeInterval?)
    case userCanceled
    case failed(Error)
}
