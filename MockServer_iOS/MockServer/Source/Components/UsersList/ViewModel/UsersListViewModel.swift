//
//  UsersListViewModel.swift
//
//  Copyright © 2017 Marco Santarossa. All rights reserved.
//

import RxSwift
import RxCocoa

protocol UsersListViewModelProtocol {
    var rx_userNames: Observable<[String]> { get }
}

final class UsersListViewModel: UsersListViewModelProtocol {

    lazy var rx_userNames: Observable<[String]> = {
        return self.createUserNames(with: self.rx_usersFetched)
    }()
    
    private unowned let configService: ConfigServiceProtocol
    private let usersListService: UsersListServiceProtocol
    
    private var rx_usersFetched: Observable<[UserModel]>
    
    init(configService: ConfigServiceProtocol, usersListService: UsersListServiceProtocol) {
        self.configService = configService
        self.usersListService = usersListService
        self.rx_usersFetched = usersListService.fetchUsers(configService: configService)
    }
}

// Observable Constructors
extension UsersListViewModel {
    fileprivate func createUserNames(with usersFetched: Observable<[UserModel]>) -> Observable<[String]> {
        return usersFetched.flatMapLatest { users -> Observable<[String]> in
                let userNames = users.flatMap { $0.name }
                return Observable.just(userNames)
            }
    }
}
