//
//  ContentView.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 05.11.24.
//

import SwiftUI
import MarkdownUI
import MLX

struct ContentView: View {
    
    @StateObject private var navigationModel = NavigationModel()
    
    var body: some View {
        NavigationStack(path: $navigationModel.navigationPath) {
            VStack {
                ForEach(NavigationOption.allCases, id: \.self) { navigationOption in
                    NavigationLink(value: navigationOption) {
                        Text(navigationOption.rawValue)
                            .foregroundStyle(.primary)
                            .font(.title)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(.thinMaterial, in: .rect(cornerRadius: 20))
                            .background(MeshGradient.custom, in: .rect(cornerRadius: 20))
                            .tint(.primary)
                    }
                }
                
                Spacer()
            }
            .navigationTitle("My A.I.")
            .navigationDestination(for: NavigationOption.self) { navigationOption in
                switch navigationOption {
                case .WritingTools:
                    WritingToolsInputView(navigationModel: navigationModel)
                case .ImagePlayground:
                    ImagePlaygroundView(navigationModel: navigationModel)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
