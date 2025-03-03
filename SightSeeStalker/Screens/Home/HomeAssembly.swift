//
//  HomeAssembly.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import UIKit

final class HomeAssembly {
    static func build() -> UIViewController {
        let view = HomeViewController()
        let worker = HomeWorker()
        //TODO: userid
        let interactor = HomeInteractor(worker: worker, userId: 0)
        let router = HomeRouter()
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
