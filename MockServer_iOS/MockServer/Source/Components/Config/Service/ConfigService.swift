//
//  MockServer
//
//  Copyright © 2017 Marco Santarossa. All rights reserved.
//

import ObjectMapper

enum ConfigEnv {
    case Debug
    case Release
    case Tests
}

protocol ConfigServiceProtocol: class {
    var apiUrl: String? { get }
}

final class ConfigService: ConfigServiceProtocol {

    private let configEnv: ConfigEnv
    private lazy var configModel: ConfigModel? = {
        guard let json = ConfigHelper.json(for: self.configEnv),
            let model = Mapper<ConfigModel>().map(JSONString: json) else {
            return nil
        }
        return model
    }()

    var apiUrl: String? {
        return configModel?.apiUrl
    }

    init(configEnv: ConfigEnv) {
        self.configEnv = configEnv
    }
}
