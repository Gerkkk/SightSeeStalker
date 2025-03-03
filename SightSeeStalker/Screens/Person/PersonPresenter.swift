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
        viewController?.displayUserPosts(articles: articles)
    }

    func presentError(_ error: Error) {
        viewController?.displayError(message: error.localizedDescription)
    }
}

