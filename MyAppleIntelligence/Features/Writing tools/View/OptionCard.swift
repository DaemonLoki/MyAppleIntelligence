//
//  OptionCard.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 07.11.24.
//

import SwiftUI

struct OptionCard: View {
    
    var title: String
    var systemImageName: String
    var action: () -> Void
    
    var option: OptionCardSize = .regular
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack(spacing: option.padding) {
                Image(systemName: systemImageName)
                    .resizable()
                    .frame(
                        width: option.buttonSize,
                        height: option.buttonSize
                    )
                
                Text(title)
                    .font(option.font)
            }
            .padding(option.padding)
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.roundedRectangle(radius: 10)
        )
        .tint(.secondary)
    }
    
}

#Preview {
    OptionCard(title: "Proofread", systemImageName: "text.magnifyingglass", action: {
        // 
    })
}
