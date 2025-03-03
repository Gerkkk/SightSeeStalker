//
//  ExploreInteractor.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import Foundation

class ExploreInteractor: ExploreInteractorProtocol {
    
    
    weak var presenter: ExplorePresenterProtocol?
    var worker: ExploreWorkerProtocol
    
    init(worker: ExploreWorkerProtocol) {
        self.worker = worker
    }
    
    func fetchData(query: String, searchType searchtype: Int, completion: @escaping (Result<ExploreDataModel, Error>) -> Void) {
        worker.fetchSearchResults(query: query, searchType: searchtype) { result in
            completion(result)
        }
    }
}
