//
//  ImageTemplateView.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 06.11.24.
//

import SwiftUI

struct ImageTemplateView: View {
    
    @State private var blurRadius: Double = 4
    @State private var rotationDegrees: Double = 10
    @State private var scaleValue: CGFloat = 1
    
    let opacityValue: Double = 0.75
    
    var body: some View {
        ZStack {
            BlobShape()
                .fill(
                    MeshGradient(width: 3, height: 3, points: [
                        [0, 0], [0.5, 0], [1, 0],
                        [0, 0.5], [0.5, 0.5], [1, 0.5],
                        [0, 1], [0.5, 1], [1, 1]
                    ], colors: [
                        .blue, .red, .purple,
                        .indigo, .orange, .pink,
                        .cyan, .green, .yellow
                    ])
                )
                .frame(width: 200, height: 200)
                .blur(radius: blurRadius)
                .rotationEffect(.degrees(rotationDegrees * -1))
                .opacity(opacityValue)
                .scaleEffect(CGSize(width: scaleValue, height: scaleValue))
            
            BlobShape()
                .fill(
                    MeshGradient(width: 3, height: 3, points: [
                        [0, 0], [0.5, 0], [1, 0],
                        [0, 0.5], [0.5, 0.5], [1, 0.5],
                        [0, 1], [0.5, 1], [1, 1]
                    ], colors: [
                        .blue, .red, .purple,
                        .indigo, .orange, .pink,
                        .cyan, .green, .yellow
                    ])
                )
                .frame(width: 200, height: 200)
                .blur(radius: blurRadius)
                .rotationEffect(.degrees(rotationDegrees))
                .opacity(opacityValue)
                .scaleEffect(CGSize(width: scaleValue * 0.95, height: scaleValue * 0.95))
            
            BlobShape()
                .fill(
                    MeshGradient(width: 3, height: 3, points: [
                        [0, 0], [0.5, 0], [1, 0],
                        [0, 0.5], [0.5, 0.5], [1, 0.5],
                        [0, 1], [0.5, 1], [1, 1]
                    ], colors: [
                        .blue, .red, .purple,
                        .indigo, .orange, .pink,
                        .cyan, .green, .yellow
                    ])
                )
                .frame(width: 200, height: 200)
                .blur(radius: blurRadius)
                .rotationEffect(.degrees((rotationDegrees - 130) * 0.6))
                .opacity(opacityValue)
                .scaleEffect(CGSize(width: scaleValue * 1.15, height: scaleValue * 1.15))
            
            BlobShape()
                .fill(
                    MeshGradient(width: 3, height: 3, points: [
                        [0, 0], [0.5, 0], [1, 0],
                        [0, 0.5], [0.5, 0.5], [1, 0.5],
                        [0, 1], [0.5, 1], [1, 1]
                    ], colors: [
                        .blue, .red, .purple,
                        .indigo, .orange, .pink,
                        .cyan, .green, .yellow
                    ])
                )
                .frame(width: 200, height: 200)
                .blur(radius: blurRadius)
                .rotationEffect(.degrees((rotationDegrees + 90) * 0.2))
                .opacity(opacityValue)
                .scaleEffect(CGSize(width: scaleValue * 1.05, height: scaleValue * 1.05))
            
            BlobShape()
                .fill(
                    MeshGradient(width: 3, height: 3, points: [
                        [0, 0], [0.5, 0], [1, 0],
                        [0, 0.5], [0.5, 0.5], [1, 0.5],
                        [0, 1], [0.5, 1], [1, 1]
                    ], colors: [
                        .blue, .red, .purple,
                        .indigo, .orange, .pink,
                        .cyan, .green, .yellow
                    ])
                )
                .frame(width: 200, height: 200)
                .blur(radius: blurRadius)
                .rotationEffect(.degrees((rotationDegrees - 240) * 0.9))
                .opacity(opacityValue)
                .scaleEffect(CGSize(width: scaleValue * 0.9, height: scaleValue * 0.95))
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                blurRadius = 6
                rotationDegrees = 200
                scaleValue = 1.2
            }
        }
    }
}

#Preview {
    ImageTemplateView()
}
