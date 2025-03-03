//
//  AuthInteractor.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 06.02.2025.
//

import Foundation
import KeychainSwift

protocol AuthInteractorProtocol {
    func login(email: String, password: String, completion: @escaping (Bool, String?) -> Void)
    func saveToken(_ token: String)
}

final class AuthInteractor: AuthInteractorProtocol {
    
    private let keychain = KeychainSwift()
    
    func login(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            if email == "" && password == "" {
                let token = "mock_jwt_token_123"
                self.saveToken(token)
                AuthState.shared.updateAuthenticationStatus(true)
                completion(true, nil)
            } else {
                completion(false, "Неверные данные")
            }
        }
    }
    
    func saveToken(_ token: String) {
        keychain.set(token, forKey: "authToken")
    }
}

