//
//  PersonInteractor.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import Foundation

protocol PersonInteractorProtocol {
    func fetchUserPosts()
}

final class PersonInteractor: PersonInteractorProtocol {
    private let worker: PersonWorker
    private let presenter: PersonPresenterProtocol
    private let userId: Int

    init(worker: PersonWorker, presenter: PersonPresenterProtocol, userId: Int) {
        self.worker = worker
        self.presenter = presenter
        self.userId = userId
    }

    func fetchUserPosts() {
        worker.fetchUserPosts(userId: userId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    self?.presenter.presentUserPosts(articles: articles)
                case .failure(let error):
                    self?.presenter.presentError(error)
                }
            }
        }
    }
}

