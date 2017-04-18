//
//  UserModel.swift
//
//  Copyright © 2017 Marco Santarossa. All rights reserved.
//

import ObjectMapper

final class UserModel: Mappable {
    
    private struct Constants {
        static let identifier = "identifier"
        static let name = "name"
    }

    var identifier: Int?
    var name: String?
    
    init?(map: Map) { }
    
    func mapping(map: Map) {
        identifier <- map[Constants.identifier]
        name <- map[Constants.name]
    }
}
