//
//  WritingToolsView.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 07.11.24.
//

import SwiftUI

struct WritingToolsView: View {
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
                }
                
                OptionCard(title: "Rewrite", systemImageName: "arrow.trianglehead.2.counterclockwise.rotate.90") {
                    // Rewrite
                }
            }
            
            HStack {
                OptionCard(title: "Friendly", systemImageName: "face.smiling", action: {
                    // Friendly tone
                }, option: .small)
                
                OptionCard(title: "Professional", systemImageName: "briefcase", action: {
                    // Friendly tone
                }, option: .small)
                
                OptionCard(title: "Concise", systemImageName: "arrow.down.and.line.horizontal.and.arrow.up", action: {
                    // Friendly tone
                }, option: .small)
            }
            
            HStack(spacing: 30) {
                SheetButton(text: "Summary") {
                    //
                }
                
                SheetButton(text: "Key Points") {
                    //
                }
                
                Divider()
                    .frame(maxHeight: 40)
                
                SheetButton(text: "Table") {
                    //
                }
                
                SheetButton(text: "List") {
                    //
                }
            }
            .frame(maxHeight: 140)
        }
        .padding()
    }
}

#Preview {
    WritingToolsView()
}
