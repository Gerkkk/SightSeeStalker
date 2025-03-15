//
//  HomePresenter.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import Foundation

final class HomePresenter {
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol
    var router: HomeRouterProtocol
    
    init(view: HomeViewProtocol, interactor: HomeInteractorProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension HomePresenter: HomePresenterProtocol {
    func viewDidLoad() {
        interactor.fetchUserInfo()
    }
    
    func didFetchUserInfo(user: PersonModel) {
        view?.showUserInfo(user)
        interactor.fetchUserPosts()
    }
    
    func didFetchUserPosts(articles: [ArticleModel]) {
        for i in 0...articles.count-1 {
            if let date = articles[i].date {
                articles[i].date = date - TimeInterval(integerLiteral: 978307200)
            }
        }
        view?.showArticles(articles)
    }
    
    func didFailWithError(error: Error) {
        view?.showError(message: error.localizedDescription)
    }
    
    func didSelectArticle(article: ArticleModel) {
        router.navigateToArticle(article: article)
    }
    
    func settingsButtonTapped() {
        router.navigateToSettings()
    }
    
    func newArticleButtonTapped() {
        router.navigateToNewArticle()
    }
}
