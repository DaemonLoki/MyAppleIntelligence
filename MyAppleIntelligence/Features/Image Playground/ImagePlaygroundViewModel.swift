//
//  ImagePlaygroundViewModel.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 06.11.24.
//

import SwiftUI

class ImagePlaygroundViewModel: ObservableObject {
    @Published var imageName: String?
    
    
    func loadImage() async throws {
        Task {
            try? await Task.sleep(for: .seconds(3))
            
            await MainActor.run {
                withAnimation {
                    imageName = "stefan"
                }
            }
        }
    }
}
