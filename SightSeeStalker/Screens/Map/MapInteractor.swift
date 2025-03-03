//
//  MapInteractor.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

class MapInteractor: MapInteractorProtocol {
    var presenter: MapPresenterProtocol!
    private let worker: MapWorkerProtocol
    
    init(worker: MapWorkerProtocol) {
        self.worker = worker
    }
    
    func fetchSelfArticles() {
        worker.loadArticles(url: "http://127.0.0.1:8000/user-actions/get-user-posts", parameters: ["id": 0]) { [weak self] result in
            switch result {
            case .success(let annotations):
                self?.presenter.handleFetchedAnnotations(annotations)
            case .failure(let error):
                self?.presenter.handleFetchError(error)
            }
        }
    }
    
    func fetchLikedArticles() {
        worker.loadArticles(url: "http://127.0.0.1:8000/user-actions/get-liked-posts", parameters: ["id": 0]) { [weak self] result in
            switch result {
            case .success(let annotations):
                self?.presenter.handleFetchedAnnotations(annotations)
            case .failure(let error):
                self?.presenter.handleFetchError(error)
            }
        }
    }
}
