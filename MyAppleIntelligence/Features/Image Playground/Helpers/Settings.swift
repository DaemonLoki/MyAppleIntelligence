//
//  Settings.swift
//  MyAppleIntelligence
//
//  Created by Stefan Blos on 10.11.24.
//

import CoreML

let DEFAULT_MODEL = ModelInfo.v21Palettized
let DEFAULT_PROMPT = "Labrador in the style of Vermeer"

typealias ComputeUnits = MLComputeUnits

class Settings {
    static let shared = Settings()
    
    let defaults = UserDefaults.standard
    
    enum Keys: String {
        case model
        case safetyCheckerDisclaimer
        case computeUnits
        case prompt
        case negativePrompt
        case guidanceScale
        case stepCount
        case previewCount
        case seed
    }

    private init() {
        defaults.register(defaults: [
            Keys.model.rawValue: ModelInfo.v21Palettized.modelId,
            Keys.safetyCheckerDisclaimer.rawValue: false,
            Keys.computeUnits.rawValue: -1,      // Use default
            Keys.prompt.rawValue: DEFAULT_PROMPT,
            Keys.negativePrompt.rawValue: "",
            Keys.guidanceScale.rawValue: 7.5,
            Keys.stepCount.rawValue: 25,
            Keys.previewCount.rawValue: 5,
            Keys.seed.rawValue: 0
        ])
    }

    var currentModel: ModelInfo {
        set {
            defaults.set(newValue.modelId, forKey: Keys.model.rawValue)
        }
        get {
            guard let modelId = defaults.string(forKey: Keys.model.rawValue) else { return DEFAULT_MODEL }
            return ModelInfo.from(modelId: modelId) ?? DEFAULT_MODEL
        }
    }

    var prompt: String {
        set {
            defaults.set(newValue, forKey: Keys.prompt.rawValue)
        }
        get {
            return defaults.string(forKey: Keys.prompt.rawValue) ?? DEFAULT_PROMPT
        }
    }

    var negativePrompt: String {
        set {
            defaults.set(newValue, forKey: Keys.negativePrompt.rawValue)
        }
        get {
            return defaults.string(forKey: Keys.negativePrompt.rawValue) ?? ""
        }
    }

    var guidanceScale: Double {
        set {
            defaults.set(newValue, forKey: Keys.guidanceScale.rawValue)
        }
        get {
            return defaults.double(forKey: Keys.guidanceScale.rawValue)
        }
    }

    var stepCount: Double {
        set {
            defaults.set(newValue, forKey: Keys.stepCount.rawValue)
        }
        get {
            return defaults.double(forKey: Keys.stepCount.rawValue)
        }
    }

    var previewCount: Double {
        set {
            defaults.set(newValue, forKey: Keys.previewCount.rawValue)
        }
        get {
            return defaults.double(forKey: Keys.previewCount.rawValue)
        }
    }

    var seed: UInt32 {
        set {
            defaults.set(String(newValue), forKey: Keys.seed.rawValue)
        }
        get {
            if let seedString = defaults.string(forKey: Keys.seed.rawValue), let seedValue = UInt32(seedString) {
                return seedValue
            }
            return 0
        }
    }

    var safetyCheckerDisclaimerShown: Bool {
        set {
            defaults.set(newValue, forKey: Keys.safetyCheckerDisclaimer.rawValue)
        }
        get {
            return defaults.bool(forKey: Keys.safetyCheckerDisclaimer.rawValue)
        }
    }
    
    /// Returns the option selected by the user, if overridden
    /// `nil` means: guess best
    var userSelectedComputeUnits: ComputeUnits? {
        set {
            // Any value other than the supported ones would cause `get` to return `nil`
            defaults.set(newValue?.rawValue ?? -1, forKey: Keys.computeUnits.rawValue)
        }
        get {
            let current = defaults.integer(forKey: Keys.computeUnits.rawValue)
            guard current != -1 else { return nil }
            return ComputeUnits(rawValue: current)
        }
    }

    public func applicationSupportURL() -> URL {
        let fileManager = FileManager.default
        guard let appDirectoryURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            // To ensure we don't return an optional - if the user domain application support cannot be accessed use the top level application support directory
            return URL.applicationSupportDirectory
        }

        do {
            // Create the application support directory if it doesn't exist
            try fileManager.createDirectory(at: appDirectoryURL, withIntermediateDirectories: true, attributes: nil)
            return appDirectoryURL
        } catch {
            print("Error creating application support directory: \(error)")
            return fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        }
    }

    func tempStorageURL() -> URL {
        
        let tmpDir = applicationSupportURL().appendingPathComponent("hf-diffusion-tmp")
        
        // Create directory if it doesn't exist
        if !FileManager.default.fileExists(atPath: tmpDir.path) {
            do {
                try FileManager.default.createDirectory(at: tmpDir, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Failed to create temporary directory: \(error)")
                return FileManager.default.temporaryDirectory
            }
        }
        
        return tmpDir
    }

}
