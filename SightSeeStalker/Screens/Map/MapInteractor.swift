//
//  MapInteractor.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import KeychainSwift

class MapInteractor: MapInteractorProtocol {
    weak var presenter: MapPresenterProtocol?
    private let worker: MapWorkerProtocol
    
    init(worker: MapWorkerProtocol) {
        self.worker = worker
    }
    
    func fetchSelfArticles() {
        let kc = KeychainSwift()
        guard let idStr = kc.get("id") else { return }
        let id = Int(idStr)
        
        worker.loadArticles(url: Config.baseURL + "/user-actions/get-user-posts", parameters: ["id": id]) { [weak self] result in
            switch result {
            case .success(let annotations):
                self?.presenter?.handleFetchedAnnotations(annotations)
            case .failure(let error):
                self?.presenter?.handleFetchError(error)
            }
        }
    }
    
    func fetchLikedArticles() {
        let kc = KeychainSwift()
        guard let idStr = kc.get("id") else { return }
        let id = Int(idStr)
        
        worker.loadArticles(url: Config.baseURL + "/user-actions/get-liked-posts", parameters: ["id": id]) { [weak self] result in
            switch result {
            case .success(let annotations):
                self?.presenter?.handleFetchedAnnotations(annotations)
            case .failure(let error):
                self?.presenter?.handleFetchError(error)
            }
        }
    }
}
