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
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first else {
            return
        }

        let navController = CustomTabBarController()
        
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}
