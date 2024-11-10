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
            Image("ai")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(
                    MeshGradient(
                        width: 3,
                        height: 2,
                        points: [
                            [0, 0], [0.5, 0], [1, 0],
                            //                    [0, 0.5], [0.5, 0.5], [1, 0.5],
                            [0, 1], [0.5, 1], [1, 1]
                        ],
                        colors: [
                            .yellow, .orange, .red,
                            .blue, .indigo, .purple
                            
                        ]
                    )
                )
        }
    }
}

#Preview {
    SiriIcon()
}
