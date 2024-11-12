//
//  ImageStyle.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 11.11.24.
//

import Foundation

enum ImageStyle: CaseIterable {
    case comic, pretty, abstract, haikei, santa
    
    var title: String {
        switch self {
        case .comic:
            "Comic"
        case .pretty:
            "Pretty"
        case .abstract:
            "Abstract"
        case .haikei:
            "Haikei"
        case .santa:
            "Santa"
        }
    }
    
    var imageName: String {
        switch self {
        case .comic:
            return "stefan"
        case .pretty:
            return "emin"
        case .abstract:
            return "abstract"
        case .haikei:
            return "haikei"
        case .santa:
            return "santa"
        }
    }
    
    var prompt: String {
        switch self {
        case .comic:
            return "Illustrate in a comic style, with bold, clear lines, vibrant colors, and expressive shading. Emphasize action, character expressions, and a playful or dramatic tone, creating a graphic novel-inspired look."
        case .pretty:
            return "Render with a pretty, soft aesthetic, using gentle colors, delicate details, and an appealing, harmonious look. Emphasize charm and elegance, focusing on visually pleasing and balanced compositions."
        case .abstract:
            return "Present in an abstract style, focusing on shapes, colors, and patterns instead of realism. Create a dynamic, expressive visual, where the impression and mood take precedence over clear forms."
        case .haikei:
            return "Render in a Haikei-inspired style, with bold, geometric shapes, gradient colors, and a minimalist, digital aesthetic. Use soft color transitions and simple forms to create a modern, artistic design."
        case .santa:
            return "Create in a festive Santa Claus theme, with warm, cheerful colors, holiday elements like snow, ornaments, and Santa himself in classic red and white attire. Capture the joy and coziness of the Christmas season."
        }
    }
}
