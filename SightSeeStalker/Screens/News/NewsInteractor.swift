//
//  NewsInteractor.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import Foundation

final class NewsInteractor: NewsInteractorProtocol {
    var presenter: NewsInteractorOutputProtocol?
    var worker: NewsWorkerProtocol = NewsWorker()
    
    var pageNum = 0
    var isLoading = false
    var allDataLoaded = false
    
    func dropValues() {
        pageNum = 0
        isLoading = false
        allDataLoaded = false
    }
    
    func fetchNews() {
        if isLoading == false && allDataLoaded == false {
            isLoading = true
            
            let parameters: [String: Any] = [
                "user_id": 0, // TODO: Fix user_id
                "page_size": 10,
                "page_num": pageNum + 1
            ]
            
            worker.fetchNews(parameters: parameters) { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                
                switch result {
                case .success(let articles):
                    if articles.count == 0 {
                        allDataLoaded = true
                        self.presenter?.didLoadAllData()
                    } else {
                        self.pageNum += 1
                        self.presenter?.newsFetched(articles)
                    }
                case .failure(let error):
                    print("Error fetching news:", error)
                }
            }
        }
    }
}

