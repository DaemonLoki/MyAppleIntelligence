//
//  SiriIcon.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 06.11.24.
//

import SwiftUI

struct SiriIcon: View {
    var body: some View {
        ZStack {
            Image(systemName: "circle.hexagonpath")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(MeshGradient(width: 3, height: 3, points: [
                    [0, 0], [0.5, 0], [1, 0],
                    [0, 0.5], [0.5, 0.5], [1, 0.5],
                    [0, 1], [0.5, 1], [1, 1]
                ], colors: [
                    .blue, .red, .purple,
                    .indigo, .orange, .pink,
                    .cyan, .green, .yellow
                ]))
                .opacity(0.9)
            
            Image(systemName: "circle.hexagonpath")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(MeshGradient(width: 3, height: 3, points: [
                    [0, 0], [0.5, 0], [1, 0],
                    [0, 0.5], [0.5, 0.5], [1, 0.5],
                    [0, 1], [0.5, 1], [1, 1]
                ], colors: [
                    .blue, .red, .purple,
                    .indigo, .orange, .pink,
                    .cyan, .green, .yellow
                ]))
                .rotationEffect(.degrees(150))
                .opacity(0.9)
                
        }
    }
}

#Preview {
    SiriIcon()
}
