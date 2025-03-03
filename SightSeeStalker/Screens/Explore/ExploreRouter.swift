//
//  ExploreRouter.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import UIKit

class ExploreRouter: ExploreRouterProtocol {
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    func navigateToPerson(person: PersonModel) {
        let personViewController = PersonAssembly.build(person: person)
        viewController?.navigationController?.pushViewController(personViewController, animated: true)
    }
    
    func navigateToArticle(article: ArticleModel) {
        let articleViewController = ArticleViewController(article: article)
        viewController?.navigationController?.pushViewController(articleViewController, animated: true)
    }
}
