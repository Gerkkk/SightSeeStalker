//
//  AuthRouter.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 06.02.2025.
//

import UIKit

final class AuthRouter {
    
    static func createAuthModule() -> UIViewController {
        let viewController = AuthViewController()
        let presenter = AuthPresenter()
        presenter.view = viewController
        viewController.presenter = presenter
        return viewController
    }
    
    static func showMainScreen() {
        guard let window = UIApplication.shared.windows.first else { return }
        let navController = CustomTabBarController()
//        navController.tabBar.removeFromSuperview()
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}
