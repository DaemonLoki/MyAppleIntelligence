//
//  WritingToolsView.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 07.11.24.
//

import SwiftUI

struct WritingToolsView: View {
    
    @ObservedObject var viewModel: WritingToolsViewModel
    
    @State private var text = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Writing Tools")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    // Close
                } label: {
                    Image(systemName: "xmark")
                        .padding(4)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.circle)
                .tint(.gray)
            }
            
            TextInputView(text: $text, placeholder: "Describe your change", showButton: true) {
                // Execute command
            }
            
            Divider()
            
            HStack {
                OptionCard(title: "Proofread", systemImageName: "text.magnifyingglass") {
                    // Proofread
                    viewModel.executeLLM(with: .proofread)
                }
                
                OptionCard(title: "Rewrite", systemImageName: "arrow.trianglehead.2.counterclockwise.rotate.90") {
                    // Rewrite
                    viewModel.executeLLM(with: .rewrite)
                }
            }
            
            HStack {
                OptionCard(title: "Friendly", systemImageName: "face.smiling", action: {
                    // Friendly tone
                    viewModel.executeLLM(with: .friendly)
                }, option: .small)
                
                OptionCard(title: "Professional", systemImageName: "briefcase", action: {
                    // Professional tone
                    viewModel.executeLLM(with: .professional)
                }, option: .small)
                
                OptionCard(title: "Concise", systemImageName: "arrow.down.and.line.horizontal.and.arrow.up", action: {
                    // Concise tone
                    viewModel.executeLLM(with: .concise)
                }, option: .small)
            }
            
            HStack(spacing: 30) {
                SheetButton(text: "Summary") {
                    // Create summary
                    viewModel.executeLLM(with: .summary)
                }
                
                SheetButton(text: "Key Points") {
                    // Extract key points
                    viewModel.executeLLM(with: .keypoints)
                }
                
                Divider()
                    .frame(maxHeight: 40)
                
                SheetButton(text: "Table") {
                    // Create table
                    viewModel.executeLLM(with: .table)
                }
                
                SheetButton(text: "List") {
                    // List
                    viewModel.executeLLM(with: .list)
                }
            }
            .frame(maxHeight: 140)
        }
        .padding()
    }
}

#Preview {
    WritingToolsView(viewModel: WritingToolsViewModel())
}
