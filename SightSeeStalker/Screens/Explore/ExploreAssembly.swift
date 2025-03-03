//
//  ExploreAssembly.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import UIKit

final class ExploreAssembly {
    static func build() -> UIViewController {
        let view = ExploreViewController()
        let worker = ExploreWorker()
        //TODO: userid
        let interactor = ExploreInteractor(worker: worker)
        let router = ExploreRouter(viewController: view)
        let presenter = ExplorePresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        presenter.router = router
        
        return view
    }
}

