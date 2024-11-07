//
//  ImagePlaygroundView.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 05.11.24.
//

import SwiftUI

struct ImagePlaygroundView: View {
    
    @ObservedObject var viewModel = ImagePlaygroundViewModel()
    
    @State private var generating = false
    
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
                if generating {
                    if let imageName = viewModel.imageName {
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
                            Image(imageName)
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
                    Text("Enter text to generate an image.")
                        .font(.title3)
                        .foregroundStyle(.yellow)
                        .padding(80)
                        .multilineTextAlignment(.center)
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
                    VStack {
                        Image("stefan")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        
                        Text("Comic")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    
                    VStack {
                        Image("emin")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        
                        Text("Pretty")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    
                    VStack {
                        Image("abstract")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        
                        Text("Abstract")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    
                    VStack {
                        Image("haikei")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        
                        Text("Haikei")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    
                    VStack {
                        Image("santa")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        
                        Text("Santa")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
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
                    // Person
                } label: {
                    Image(systemName: "person.fill")
                        .padding(12)
                }
                .foregroundStyle(.primary)
                .buttonStyle(.bordered)
                .buttonBorderShape(.circle)
                
                Button {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                    
                    withAnimation {
                        generating = true
                    }
                    
                    Task {
                        try? await viewModel.loadImage()
                    }
                } label: {
                    Image(systemName: "plus")
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
    }
}

#Preview {
    ImagePlaygroundView()
}
