//
//  AuthPresenter.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 06.02.2025.
//

import Foundation

final class AuthPresenter {
    
    private let interactor: AuthInteractorProtocol = AuthInteractor()
    weak var view: AuthViewController?
    
    func login(email: String, password: String) {
        interactor.login(email: email, password: password) { [weak self] success, errorMessage in
            DispatchQueue.main.async {
                if success {
                    AuthRouter.showMainScreen()
                } else {
                    self?.view?.showError(message: errorMessage ?? "Ошибка")
                }
            }
        }
    }
}
