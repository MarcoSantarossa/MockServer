//
//  MockServer
//
//  Copyright © 2017 Marco Santarossa. All rights reserved.
//

import ObjectMapper

final class ConfigModel: Mappable {

    private struct Constants {
        static let apiUrl = "api_url"
    }

    var apiUrl: String?

    required init?(map: Map) { }

    // Mappable
    func mapping(map: Map) {
        apiUrl <- map[Constants.apiUrl]
    }
}
