//
//  WritingToolOption.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 09.11.24.
//

import Foundation

enum WritingToolOption {
    case proofread, rewrite, friendly, professional, concise, summary, keypoints, table, list
    
    //    func generatePrompt(with text: String) -> String {
    //        switch self {
    //        case .proofread:
    //            return "Proofread the following text. Correct any spelling, grammar, or punctuation errors without changing the meaning. Make sure the text reads smoothly and is error-free: \(text)"
    //        case .rewrite:
    //            return "Rewrite the following text to improve clarity, readability, and flow. Preserve the meaning, but make it more engaging and natural: \(text)"
    //        case .friendly:
    //            return "Rewrite the following text in a friendly, approachable tone. Use conversational language and make it sound warm and welcoming while preserving the original message: \(text)"
    //        case .professional:
    //            return "Rewrite the following text in a professional and formal tone. Make it sound polished, precise, and suitable for a business or formal setting: \(text)"
    //        case .concise:
    //            return "Rewrite the following text to be as concise as possible without losing any important details or meaning. Eliminate any unnecessary words: \(text)"
    //        case .summary:
    //            return "Summarize the following text in a few sentences, capturing only the essential points and main ideas: \(text)"
    //        case .keypoints:
    //            return "Extract the key points from the following text. Present them as bullet points and cover the main ideas or important details: \(text)"
    //        case .table:
    //            return "Convert the information in the following text into a structured table format. Organize it into relevant categories or columns for clarity: \(text)"
    //        case .list:
    //            return "Convert the following text into a list of bullet points. Each point should represent a distinct idea or item for easy reading: \(text)"
    //        }
    //    }
    
}


extension WritingToolOption {
    func generatePrompt(with text: String) -> String {
        switch self {
        case .proofread:
            return "Proofread the following text. Correct any spelling, grammar, or punctuation errors without changing the meaning. Make sure the text reads smoothly and is error-free: \(text)"
        case .rewrite:
            return "Rewrite the following text to improve clarity, readability, and flow. Preserve the meaning, but make it more engaging and natural: \(text)"
        case .friendly:
            return "Rewrite the following text in a friendly, approachable tone. Use conversational language and make it sound warm and welcoming while preserving the original message: \(text)"
        case .professional:
            return "Rewrite the following text in a professional and formal tone. Make it sound polished, precise, and suitable for a business or formal setting: \(text)"
        case .concise:
            return "Rewrite the following text to be as concise as possible without losing any important details or meaning. Eliminate any unnecessary words: \(text)"
        case .summary:
            return "Summarize the following text in a few sentences, capturing only the essential points and main ideas: \(text)"
        case .keypoints:
            return "Extract the key points from the following text. Present them as bullet points and cover the main ideas or important details: \(text)"
        case .table:
            return "Convert the information in the following text into a structured table format. Organize it into relevant categories or columns for clarity: \(text)"
        case .list:
            return "Convert the following text into a list of bullet points. Each point should represent a distinct idea or item for easy reading: \(text)"
        }
    }
}
