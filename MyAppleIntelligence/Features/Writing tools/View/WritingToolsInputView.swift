//
//  WritingToolsInputView.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 09.11.24.
//

import SwiftUI

struct WritingToolsInputView: View {
    
    @ObservedObject var navigationModel: NavigationModel
    @StateObject var viewModel = WritingToolsViewModel()
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Button {
                    navigationModel.navigationPath.removeLast()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .padding(8)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.circle)
                .tint(.gray)
                
                Text("Input text")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                
                
                Button {
                    viewModel.showingWritingTools.toggle()
                } label: {
                    SiriIcon()
                        .frame(width: 32, height: 32)
                }
            }
            .padding()
            
            ZStack {
                TextEditor(text: $viewModel.textInput)
                    .scrollContentBackground(.hidden)
                    .foregroundStyle(.primary)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .clipShape(.rect(cornerRadius: 20, style: .continuous))
                    .padding()
                    .overlay {
                        if viewModel.analyzingText {
                            ZStack {
                                Color(.white)
                                    .opacity(0.6)
                                    .clipShape(.rect(cornerRadius: 20, style: .continuous))
                                    .padding()
                                
                                TimelineView(.animation) { timeline in
                                    let time = viewModel.startDate.distance(to: timeline.date)
                                    
                                    Color.white.opacity(0.5)
                                        .clipShape(.rect(cornerRadius: 20, style: .continuous))
                                        .padding()
                                        .visualEffect { content, proxy in
                                            content
                                                .colorEffect(ShaderLibrary.shimmer(
                                                    .float2(proxy.size),
                                                    .float(time),
                                                    .float(2.0),
                                                    .float(0.9),
                                                    .float(0.5)))
                                        }
                                }
                            }
                        }
                    }
                    
                
            }
        }
        .sheet(isPresented: $viewModel.showingWritingTools) {
            WritingToolsView(viewModel: viewModel)
                .presentationDetents([.medium])
                .presentationDragIndicator(.hidden)
        }
        .task {
            _ = try? await viewModel.load()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    WritingToolsInputView(navigationModel: NavigationModel())
}
