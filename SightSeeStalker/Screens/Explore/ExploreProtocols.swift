//
//  ExploreProtocols.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import Foundation

protocol ExploreViewProtocol: AnyObject {
    func reloadData()
    func setError(_ error: Error)
    func setResults(articles: [ArticleModel], people: [PersonModel])
}

protocol ExplorePresenterProtocol: AnyObject {
    func viewDidLoad()
    func searchWithParams(query: String, searchType: Int)
    func personSelected(person: PersonModel)
    func articleSelected(article: ArticleModel)
}

protocol ExploreInteractorProtocol: AnyObject {
    func fetchData(query: String, searchType: Int, completion: @escaping (Result<ExploreDataModel, Error>) -> Void)
}

protocol ExploreWorkerProtocol: AnyObject {
    func fetchSearchResults(query: String, searchType: Int, completion: @escaping (Result<ExploreDataModel, Error>) -> Void)
}

protocol ExploreRouterProtocol: AnyObject {
    func navigateToPerson(person: PersonModel)
    func navigateToArticle(article: ArticleModel)
}
