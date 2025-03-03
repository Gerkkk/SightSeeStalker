//
//  HomeInteractor.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import Foundation

final class HomeInteractor: HomeInteractorProtocol {
    weak var presenter: HomePresenterProtocol?
    private let worker: HomeWorkerProtocol
    private let userId: Int
    
    init(worker: HomeWorkerProtocol, userId: Int) {
        self.worker = worker
        self.userId = userId
    }
    
    func fetchUserInfo() {
        worker.getUserInfo(id: userId) { [weak self] result in
            switch result {
            case .success(let user):
                self?.presenter?.didFetchUserInfo(user: user)
            case .failure(let error):
                self?.presenter?.didFailWithError(error: error)
            }
        }
    }
    
    func fetchUserPosts() {
        worker.getUserPosts(id: userId) { [weak self] result in
            switch result {
            case .success(let articles):
                self?.presenter?.didFetchUserPosts(articles: articles)
            case .failure(let error):
                self?.presenter?.didFailWithError(error: error)
            }
        }
    }
}
