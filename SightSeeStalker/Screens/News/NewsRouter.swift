//
//  NewsRouter.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import UIKit

final class NewsRouter: NewsRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = NewsViewController()
        let presenter = NewsPresenter()
        let interactor = NewsInteractor()
        let router = NewsRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func navigateToArticleDetail(_ article: ArticleModel) {
        print(1)
        let articleVC = ArticleViewController(article: article)
        viewController?.navigationController?.pushViewController(articleVC, animated: true)
    }
}

