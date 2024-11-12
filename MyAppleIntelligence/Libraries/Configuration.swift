//
//  Configuration.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 08.11.24.
//

import Foundation

public enum StringOrNumber: Codable, Equatable, Sendable {
    case string(String)
    case float(Float)

    public init(from decoder: Decoder) throws {
        let values = try decoder.singleValueContainer()

        if let v = try? values.decode(Float.self) {
            self = .float(v)
        } else {
            let v = try values.decode(String.self)
            self = .string(v)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let v): try container.encode(v)
        case .float(let v): try container.encode(v)
        }
    }
}

private class ModelTypeRegistry: @unchecked Sendable {

    // Note: using NSLock as we have very small (just dictionary get/set)
    // critical sections and expect no contention.  this allows the methods
    // to remain synchronous.
    private let lock = NSLock()

    @Sendable
    private static func createLlamaModel(url: URL) throws -> LLMModel {
        let configuration = try JSONDecoder().decode(
            LlamaConfiguration.self, from: Data(contentsOf: url))
        return LlamaModel(configuration)
    }
    
    private var creators: [String: @Sendable (URL) throws -> LLMModel] = [
        "llama": createLlamaModel,
    ]

    public func registerModelType(
        _ type: String, creator: @Sendable @escaping (URL) throws -> LLMModel
    ) {
        lock.withLock {
            creators[type] = creator
        }
    }

    public func createModel(configuration: URL, rawValue: String) throws -> LLMModel {
        let creator = lock.withLock {
            creators[rawValue]
        }
        guard let creator else {
            throw LLMError(message: "Unsupported model type.")
        }
        return try creator(configuration)
    }

}

private let modelTypeRegistry = ModelTypeRegistry()

public struct ModelType: RawRepresentable, Codable, Sendable {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    public static func registerModelType(
        _ type: String, creator: @Sendable @escaping (URL) throws -> LLMModel
    ) {
        modelTypeRegistry.registerModelType(type, creator: creator)
    }

    public func createModel(configuration: URL) throws -> LLMModel {
        try modelTypeRegistry.createModel(configuration: configuration, rawValue: rawValue)
    }
}

public struct BaseConfiguration: Codable, Sendable {
    public let modelType: ModelType

    public struct Quantization: Codable, Sendable {
        public init(groupSize: Int, bits: Int) {
            self.groupSize = groupSize
            self.bits = bits
        }

        let groupSize: Int
        let bits: Int

        enum CodingKeys: String, CodingKey {
            case groupSize = "group_size"
            case bits = "bits"
        }
    }

    public var quantization: Quantization?

    enum CodingKeys: String, CodingKey {
        case modelType = "model_type"
        case quantization
    }
}
