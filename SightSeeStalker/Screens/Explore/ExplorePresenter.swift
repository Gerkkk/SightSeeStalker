//
//  ExplorePresenter.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import Foundation

class ExplorePresenter: ExplorePresenterProtocol {
    
    weak var view: ExploreViewProtocol?
    var interactor: ExploreInteractorProtocol
    var router: ExploreRouterProtocol
    
    init(view: ExploreViewProtocol, interactor: ExploreInteractorProtocol, router: ExploreRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        searchWithParams(query: "", searchType: 0)
    }
    
    func searchWithParams(query: String, searchType: Int) {
        interactor.fetchData(query: query, searchType: searchType) { [weak self] result in
            switch result {
            case .success(let data):
                let retArticles = data.articles ?? []
                let retPeople = data.people ?? []
                self?.view?.setResults(articles: retArticles, people: retPeople)
                self?.view?.reloadData()
            case .failure(let error):
                self?.view?.setError(error)
            }
        }
    }
    
    func personSelected(person: PersonModel) {
        self.router.navigateToPerson(person: person)
    }
    
    func articleSelected(article: ArticleModel) {
        self.router.navigateToArticle(article: article)
    }
}
