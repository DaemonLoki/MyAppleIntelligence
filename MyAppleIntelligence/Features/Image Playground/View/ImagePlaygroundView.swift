//
//  ImagePlaygroundView.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 05.11.24.
//

import SwiftUI

struct ImagePlaygroundView: View {
    
    @ObservedObject var viewModel = ImagePlaygroundViewModel()
    
    @State private var text = ""
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    print("Cancel")
                } label: {
                    Text("Cancel")
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .foregroundStyle(.primary)
                
                Spacer()
                
                Button {
                    print("Done")
                } label: {
                    Text("Done")
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .foregroundStyle(.primary)
                .tint(.yellow)
            }
            .padding(.horizontal)
            
            Spacer()
            
            ZStack {
                if viewModel.generating {
                    if let generatedImage = viewModel.generatedImage {
                        TimelineView(.animation) { timeline in
                            let x = (sin(timeline.date.timeIntervalSince1970) + 1) / 1
                            
                            MeshGradient(width: 3, height: 3, points: [
                                [0, 0], [0.5, 0], [1, 0],
                                [0, 0.5], [Float(x), 0.5], [1, 0.5],
                                [0, 1], [0.5, 1], [1, 1]
                            ], colors: [
                                .blue, .red, .purple,
                                .indigo, .orange, .pink,
                                .cyan, .green, .yellow
                            ])
                            .frame(width: 350, height: 350)
                            .blur(radius: 10)
                            .rotationEffect(.degrees(x * 100))
                        }
                        .frame(width: 250, height: 250)
                        .clipShape(.rect(cornerRadius: 20, style: .continuous))
                        .blur(radius: 6)
                        .overlay {
                            Image(uiImage: UIImage(cgImage: generatedImage))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 235, height: 235)
                                .background(Color.gray.opacity(0.4))
                                .clipShape(.rect(cornerRadius: 20, style: .continuous))
                                .overlay {
                                    RoundedRectangle(
                                        cornerRadius: 20,
                                        style: .continuous
                                    )
                                    .stroke(
                                        MeshGradient(width: 3, height: 3, points: [
                                            [0, 0], [0.5, 0], [1, 0],
                                            [0, 0.5], [0.5, 0.5], [1, 0.5],
                                            [0, 1], [0.5, 1], [1, 1]
                                        ], colors: [
                                            .blue, .red, .purple,
                                            .indigo, .orange, .pink,
                                            .cyan, .green, .yellow
                                        ]), lineWidth: 20)
                                    .frame(width: 250, height: 250)
                                    .blur(radius: 10)
                                }
                        }
                        .transition(.scale)
                    } else {
                        ImageTemplateView()
                            .transition(.scale)
                    }
                } else {
                    if viewModel.currentView == .ready {
                        GradientLabelView(text: "Enter text to generate an image.")
                            .transition(.scale)
                    }
                }
                
                ZStack {
                    switch viewModel.currentView {
                    case .loading:
                        GradientLabelView(text: "Loading the model...")
                            .transition(.scale)
                    case .ready:
                        EmptyView()
                    case .error(let string):
                        GradientLabelView(text: "Error: \(string)")
                            .transition(.scale)
                    }
                }
                
                if viewModel.preparationPhase == .Downloading {
                    GradientLabelView(text: String(format: "Downloading: %.1f", viewModel.downloadProgress * 100))
                }
            }
            
            
            Spacer()
            
            VStack {
                HStack {
                    Text("Suggestions".uppercased())
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    Button {
                        // Show more
                    } label: {
                        Text("Show more".uppercased())
                            .font(.subheadline)
                    }
                    .buttonStyle(.borderless)
                    .tint(.yellow)
                    
                }
                .padding()
                
                HStack {
                    ForEach(ImageStyle.allCases, id: \.self) { imageStyle in
                        Button {
                            viewModel.generate(prompt: "\(text) with the following style: \(imageStyle.prompt)")
                        } label: {
                            VStack {
                                Image(imageStyle.imageName)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                
                                Text(imageStyle.title)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                    }
                }
                .padding()
            }
            
            HStack(spacing: 4) {
                HStack(spacing: 12) {
                    SiriIcon()
                        .frame(width: 32, height: 32)
                    
                    TextField(text: $text, prompt: Text("Describe an image")) {
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .padding(.vertical, 2)
                .padding(.horizontal, 12)
                .background(Color(uiColor: .secondarySystemBackground), in: Capsule())
                
                Button {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)

                    viewModel.generate(prompt: text)
                } label: {
                    Image(systemName: "arrow.up")
                        .padding(12)
                }
                .foregroundStyle(.primary)
                .buttonStyle(.bordered)
                .buttonBorderShape(.circle)
            }
            .padding(.horizontal)
            
            HStack(alignment: .firstTextBaseline) {
                Text("BETA")
                    .padding(4)
                    .font(.caption)
                    .background(.gray, in: Capsule())
                
                Text("Image may vary based on description, prettiness of the creator, or president selected.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
        }
        .task {
            await viewModel.loadModel()
        }
    }
}

#Preview {
    ImagePlaygroundView()
}
