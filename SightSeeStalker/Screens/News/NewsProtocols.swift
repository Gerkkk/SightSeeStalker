//
//  NewsProtocols.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import Foundation

protocol NewsViewProtocol: AnyObject {
    func showNews(_ articles: [ArticleModel])
}

protocol NewsPresenterProtocol: AnyObject {
    func fetchNews()
    func didSelectArticle(_ article: ArticleModel)
    func dropValues()
}

protocol NewsInteractorProtocol: AnyObject {
    func fetchNews()
    func dropValues()
}

protocol NewsInteractorOutputProtocol: AnyObject {
    func newsFetched(_ articles: [ArticleModel])
    func didLoadAllData()
}

protocol NewsRouterProtocol: AnyObject {
    func navigateToArticleDetail(_ article: ArticleModel)
}

