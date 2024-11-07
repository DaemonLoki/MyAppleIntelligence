//
//  TextInputView.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 07.11.24.
//

import SwiftUI

struct TextInputView: View {
    
    @Binding var text: String
    var placeholder: String = "Describe an image"
    var showButton: Bool = true
    var sendAction: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            SiriIcon()
                .frame(width: 32, height: 32)
            
            TextField(text: $text, prompt: Text(placeholder)) {
                EmptyView()
            }
            .frame(maxWidth: .infinity)
            
            if showButton {
                Button {
                    sendAction()
                } label: {
                    Image(systemName: "arrow.up")
                    
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.circle)
                .tint(.gray)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .padding(.vertical, 2)
        .padding(.horizontal, 12)
        .background(Color(uiColor: .secondarySystemBackground), in: Capsule())
    }
}

#Preview {
    @Previewable @State var text: String = "test"
    TextInputView(text: $text) {
        print("Send")
    }
}
