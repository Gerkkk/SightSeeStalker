//
//  HomeRouter.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import UIKit


final class HomeRouter: HomeRouterProtocol {
    weak var viewController: UIViewController?
    
    func navigateToArticle(article: ArticleModel) {
        let articleVC = ArticleViewController(article: article)
        viewController?.navigationController?.pushViewController(articleVC, animated: true)
    }
    
    func navigateToSettings() {
        let settingsVC = SettingsViewController()
        viewController?.navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    func navigateToNewArticle() {
        let newArticleVC = NewArticleViewController()
        viewController?.navigationController?.pushViewController(newArticleVC, animated: true)
    }
}
