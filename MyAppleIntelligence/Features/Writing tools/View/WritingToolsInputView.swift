//
//  WritingToolsInputView.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 09.11.24.
//

import SwiftUI

struct WritingToolsInputView: View {
    
    @ObservedObject var viewModel = WritingToolsViewModel()
    
    @State private var showingWritingTools = false
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Input text")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    showingWritingTools.toggle()
                } label: {
                    SiriIcon()
                        .frame(width: 32, height: 32)
                }
            }
            .padding()
            
            TextEditor(text: $viewModel.textInput)
                .scrollContentBackground(.hidden)
                .foregroundStyle(.primary)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .clipShape(.rect(cornerRadius: 20, style: .continuous))
                .padding()
        }
        .sheet(isPresented: $showingWritingTools) {
            WritingToolsView(viewModel: viewModel)
                .presentationDetents([.medium])
                .presentationDragIndicator(.hidden)
        }
        .task {
            _ = try? await viewModel.load()
        }
    }
}

#Preview {
    WritingToolsInputView()
}
