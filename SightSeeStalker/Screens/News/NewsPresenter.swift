//
//  NewsPresenter.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import Foundation

final class NewsPresenter: NewsPresenterProtocol {
    weak var view: NewsViewProtocol?
    var interactor: NewsInteractorProtocol?
    var router: NewsRouterProtocol?
    
    func fetchNews() {
        interactor?.fetchNews()
    }
    
    func didSelectArticle(_ article: ArticleModel) {
        router?.navigateToArticleDetail(article)
    }
}

// MARK: - NewsInteractorOutputProtocol
extension NewsPresenter: NewsInteractorOutputProtocol {
    func newsFetched(_ articles: [ArticleModel]) {
        view?.showNews(articles)
    }
    
    func didLoadAllData() {
        print("All news were loaded")
    }
}

