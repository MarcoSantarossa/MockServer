//
//  UsersListCoordinator.swift
//
//  Copyright © 2017 Marco Santarossa. All rights reserved.
//

import UIKit

final class UsersListCoordinator: Coordinator {
    
    private unowned let navigationController: UINavigationController
    private unowned let configService: ConfigServiceProtocol
    
    init(navigationController: UINavigationController, configService: ConfigServiceProtocol) {
        self.navigationController = navigationController
        self.configService = configService
    }
    
    func start() {
        let usersListService = UsersListService()
        let viewModel = UsersListViewModel(configService: configService, usersListService: usersListService)
        let view = UsersListTableViewController(viewModel: viewModel)
        
        navigationController.pushViewController(view, animated: true)
    }
}
