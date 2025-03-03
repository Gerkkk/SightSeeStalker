//
//  HomeProtocols.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import Foundation

protocol HomeInteractorProtocol: AnyObject {
    func fetchUserInfo()
    func fetchUserPosts()
}

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func didFetchUserInfo(user: PersonModel)
    func didFetchUserPosts(articles: [ArticleModel])
    func didFailWithError(error: Error)
    func newArticleButtonTapped()
    func settingsButtonTapped()
    func didSelectArticle(article: ArticleModel)
}

protocol HomeViewProtocol: AnyObject {
    func showUserInfo(_ user: PersonModel)
    func showArticles(_ articles: [ArticleModel])
    func showError(message: String)
}

protocol HomeWorkerProtocol {
    func getUserInfo(id: Int, completion: @escaping (Result<PersonModel, Error>) -> Void)
    func getUserPosts(id: Int, completion: @escaping (Result<[ArticleModel], Error>) -> Void)
}

protocol HomeRouterProtocol {
    func navigateToArticle(article: ArticleModel)
    func navigateToSettings()
    func navigateToNewArticle()
}


