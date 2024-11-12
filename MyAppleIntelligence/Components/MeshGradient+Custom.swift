//
//  MeshGradient+Custom.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 11.11.24.
//

import SwiftUI

extension MeshGradient {
    
    static var custom: MeshGradient {
        return MeshGradient(
            width: 3,
            height: 2,
            points: [
                [0, 0], [0.5, 0], [1, 0],
                [0, 1], [0.5, 1], [1, 1]
            ],
            colors: [
                .yellow, .orange, .red,
                .blue, .indigo, .purple
                
            ]
        )
    }
    
}
