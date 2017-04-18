//
//  UsersListService.swift
//
//  Copyright © 2017 Marco Santarossa. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift
import RxCocoa

protocol UsersListServiceProtocol {
    func fetchUsers(configService: ConfigServiceProtocol) -> Observable<[UserModel]>
}

final class UsersListService: UsersListServiceProtocol {
    
    func fetchUsers(configService: ConfigServiceProtocol) -> Observable<[UserModel]> {
        guard let apiUrl = configService.apiUrl else {
            let error = NSError(domain: "APIUrlNotSet", code: 0, userInfo: nil)
            return Observable.error(error)
        }
        let url = apiUrl + "users"
        let req = URLRequest(url: URL(string: url)!)
        
        return URLSession.shared.rx.json(request: req)
            .flatMap { [weak self] data -> Observable<[UserModel]> in
                guard let strongSelf = self else {
                    let error = NSError(domain: "ServiceReferenceDestroyed", code: 0, userInfo: nil)
                    return Observable.error(error)
                }
                return strongSelf.parseResponse(data: data)
            }
    }
    
    private func parseResponse(data: Any) -> Observable<[UserModel]> {
        guard let json = data as? JSON,
            let users = self.parseUsers(from: json) else {
            let error = NSError(domain: "ParsingError", code: 0, userInfo: nil)
            return Observable.error(error)
        }
        
        return Observable.just(users)
    }
    
    private func parseUsers(from json: JSON) -> [UserModel]? {
        return Mapper<UserModel>().mapArray(JSONArray: json)
    }
}
