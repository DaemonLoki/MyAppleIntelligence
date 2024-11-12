//
//  ImageWithPlaceholder.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 10.11.24.
//

import SwiftUI

struct ImageWithPlaceholder: View {
    
    @ObservedObject var viewModel: ImagePlaygroundViewModel
    
    var body: some View {
        switch viewModel.generation.state {
        case .startup: return AnyView(Image("placeholder").resizable())
        case .running(let progress):
            guard let progress = progress, progress.stepCount > 0 else {
                // The first time it takes a little bit before generation starts
                return AnyView(ProgressView())
            }

            let step = Int(progress.step) + 1
            let fraction = Double(step) / Double(progress.stepCount)
            let label = "Step \(step) of \(progress.stepCount)"
            return AnyView(VStack {
                Group {
                    if let safeImage = viewModel.generation.previewImage {
                        Image(safeImage, scale: 1, label: Text("generated"))
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
                ProgressView(label, value: fraction, total: 1).padding()
            })
        case .complete(let lastPrompt, let image, _, let interval):
            guard let theImage = image else {
                return AnyView(Image(systemName: "exclamationmark.triangle").resizable())
            }
                              
            let imageView = Image(theImage, scale: 1, label: Text("generated"))
            return AnyView(
                VStack {
                    imageView
                        .resizable()
                        .frame(width: 200, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    HStack {
                        let intervalString = String(format: "Time: %.1fs", interval ?? 0)
                        Rectangle().fill(.clear).overlay(Text(intervalString).frame(maxWidth: .infinity, alignment: .leading).padding(.leading))
                    }.frame(maxHeight: 25)
            })
        case .failed(_):
            return AnyView(Image(systemName: "exclamationmark.triangle").resizable())
        case .userCanceled:
            return AnyView(Text("Generation canceled"))
        }
    }
}

#Preview {
    ImageWithPlaceholder(viewModel: ImagePlaygroundViewModel())
}
