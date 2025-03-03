//
//  HomePresenter.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

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
