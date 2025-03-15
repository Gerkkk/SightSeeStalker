//
//  ExploreInteractor.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import Foundation

public class ExploreInteractor: ExploreInteractorProtocol {
    weak var presenter: ExplorePresenterProtocol?
    var worker: ExploreWorkerProtocol
    
    public init(worker: ExploreWorkerProtocol) {
        self.worker = worker
    }
    
    public func fetchData(query: String, searchType searchtype: Int, completion: @escaping (Result<ExploreDataModel, Error>) -> Void) {
        
        DispatchQueue.global().asyncAfter(deadline: .now()) {[weak self] in
            self?.worker.fetchSearchResults(query: query, searchType: searchtype) { result in
                completion(result)
            }
        }
    }
}
