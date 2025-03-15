//
//  NewArticleAssembly.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 12.03.2025.
//

import UIKit

final class NewArticleAssembly {
    static func build() -> UIViewController {
        let view = NewArticleViewController()
        let worker = NewArticleWorker()
        //TODO: userid
        let interactor = NewArticleInteractor(worker: worker)
        let router = NewArticleRouter()
        let presenter = NewArticlePresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
}
