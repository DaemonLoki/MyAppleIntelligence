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
                    MeshGradient.custom
                )
        }
    }
}

#Preview {
    SiriIcon()
}
