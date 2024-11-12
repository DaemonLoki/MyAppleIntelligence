//
//  NavigationModel.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 12.11.24.
//

import SwiftUI

@MainActor
class NavigationModel: ObservableObject {
    @Published var navigationPath = NavigationPath()
}
