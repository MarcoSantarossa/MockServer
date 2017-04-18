//
//  MockServer
//
//  Copyright © 2017 Marco Santarossa. All rights reserved.
//

import Foundation

final class ConfigHelper {
    static var configEnv: ConfigEnv {
        #if DEBUG
            return .Debug
        #elseif RELEASE
            return .Release
        #elseif TESTS
            return .Tests
        #else
            fatalError("Config flag not found")
        #endif
    }

    static func json(for configEnv: ConfigEnv) -> String? {
        guard let file = jsonFile(for: configEnv) else { return nil }
        return try! String(contentsOfFile: file)
    }

    private static func jsonFile(for configEnv: ConfigEnv) -> String? {
        var fileName: String? = nil
        switch configEnv {
        case .Debug:
            fileName = "Config-Debug"
        case .Release:
            fileName = "Config-Release"
        case .Tests:
            fileName = "Config-Test"
        }

        return Bundle.main.path(forResource: fileName, ofType: "json")
    }
}
