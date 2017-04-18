//
//  MockServer
//
//  Copyright © 2017 Marco Santarossa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var mainCoordinator: Coordinator?
    private var configService: ConfigService?

    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        return navigationController
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = navigationController
        
        self.configService = ConfigService(configEnv: ConfigHelper.configEnv)
        let coordinator = UsersListCoordinator(navigationController: navigationController, configService: configService!)
        coordinator.start()
        window?.makeKeyAndVisible()
        
        mainCoordinator = coordinator
        
        return true
    }
}

