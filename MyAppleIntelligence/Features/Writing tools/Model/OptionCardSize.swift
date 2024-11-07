//
//  OptionCardSize.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 07.11.24.
//

import SwiftUI

enum OptionCardSize {
    case regular, small
    
    var buttonSize: CGFloat {
        switch self {
        case .regular: return 24
        case .small: return 18
        }
    }
    
    var font: Font {
        switch self {
        case .regular:
            return .body
        case .small:
            return .caption
        }
    }
    
    var padding: CGFloat {
        switch self {
        case .regular:
            return 8
        case .small:
            return 4
        }
    }
}
