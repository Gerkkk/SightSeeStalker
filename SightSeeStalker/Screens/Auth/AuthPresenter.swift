//
//  AuthPresenter.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 06.02.2025.
//

import Foundation

final class AuthPresenter {
    private enum Constants {
        static let defaultErrorMessage = "Error"
    }
    private let interactor: AuthInteractorProtocol = AuthInteractor()
    weak var view: AuthViewController?
    
    func login(tag: String, password: String) {
        interactor.login(tag: tag, password: password) { [weak self] success, errorMessage in
            DispatchQueue.main.async {
                if success {
                    AuthRouter.showMainScreen()
                } else {
                    self?.view?.showError(message: errorMessage?[0] ?? Constants.defaultErrorMessage)
                }
            }
        }
    }
}
