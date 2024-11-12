//
//  GradientLabelView.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 11.11.24.
//

import SwiftUI

struct GradientLabelView: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundStyle(.secondary)
            .font(.subheadline)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(.thinMaterial, in: Capsule())
            .background(MeshGradient.custom, in: Capsule())
    }
}

#Preview {
    GradientLabelView(text: "Model loading...")
}
