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
    
    func dropValues() {
        interactor?.dropValues()
    }
    
    func didSelectArticle(_ article: ArticleModel) {
        router?.navigateToArticleDetail(article)
    }
}

// MARK: - NewsInteractorOutputProtocol
extension NewsPresenter: NewsInteractorOutputProtocol {
    func newsFetched(_ articles: [ArticleModel]) {
        for i in 0...articles.count-1 {
            if let date = articles[i].date {
                articles[i].date = date - TimeInterval(integerLiteral: 978307200)
            }
        }
        
        view?.showNews(articles)
    }
    
    func didLoadAllData() {
        print("All news were loaded")
    }
}

