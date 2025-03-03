//
//  PersonRouter.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import UIKit

protocol PersonRouterProtocol {
    func navigateToArticle(article: ArticleModel)
}

final class PersonRouter: PersonRouterProtocol {
    weak var viewController: UIViewController?

    func navigateToArticle(article: ArticleModel) {
        let articleVC = ArticleViewController(article: article)
        viewController?.navigationController?.pushViewController(articleVC, animated: true)
    }
}
