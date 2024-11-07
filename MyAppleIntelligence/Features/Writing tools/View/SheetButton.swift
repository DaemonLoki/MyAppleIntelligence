//
//  SheetButton.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 07.11.24.
//

import SwiftUI

struct SheetButton: View {
    
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color(uiColor: .tertiarySystemGroupedBackground))
                    .aspectRatio(3 / 4, contentMode: .fit)
                    .shadow(radius: 8)
                
                Text(text)
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
        }
        .tint(.primary)
    }
}

#Preview {
    SheetButton(text: "Summary") {}
}
