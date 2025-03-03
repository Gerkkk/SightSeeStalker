//
//  NewsAssembly.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import UIKit

enum NewsAssembly {
    static func build() -> UIViewController {
        let router = NewsRouter()
        let presenter = NewsPresenter()
        let interactor = NewsInteractor()
        let viewController = NewsViewController()

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
}
