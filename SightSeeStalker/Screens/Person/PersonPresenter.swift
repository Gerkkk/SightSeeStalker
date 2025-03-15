//
//  PersonPresenter.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import Foundation

protocol PersonPresenterProtocol {
    func presentUserPosts(articles: [ArticleModel])
    func presentError(_ error: Error)
}

final class PersonPresenter: PersonPresenterProtocol {
    weak var viewController: PersonViewControllerProtocol?

    func presentUserPosts(articles: [ArticleModel]) {
        for i in 0...articles.count-1 {
            if let date = articles[i].date {
                articles[i].date = date - TimeInterval(integerLiteral: 978307200)
            }
        }
        viewController?.displayUserPosts(articles: articles)
    }

    func presentError(_ error: Error) {
        viewController?.displayError(message: error.localizedDescription)
    }
}

