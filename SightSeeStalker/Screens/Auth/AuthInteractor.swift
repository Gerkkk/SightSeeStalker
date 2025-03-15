//
//  AuthInteractor.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 06.02.2025.
//

import Foundation
import KeychainSwift

protocol AuthInteractorProtocol {
    func login(tag: String, password: String, completion: @escaping (Bool, [String]?) -> Void)
    func saveTokenAndID(_ tokens: [String]?)
}

final class AuthInteractor: AuthInteractorProtocol {
    private var worker = AuthWorker()
    private let keychain = KeychainSwift()
    
    func login(tag: String, password: String, completion: @escaping (Bool, [String]?) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            var token = ""
            var id = -1
            
            self.worker.login(url: Config.baseURL + "/auth/login", parameters: ["tag": tag, "password": password]) { [weak self] result in
                guard let self = self else { return }
                print(result)
                switch result {
                case .success(let retData):
                    token = retData.accessToken
                    id = retData.id
                case .failure(let error):
                    print("Error logging in:", error)
                }
                
                if id == -1 {
                    completion(false, ["Неверные данные"])
                } else {
                    self.saveTokenAndID([token, String(id)])
                    AuthState.shared.updateAuthenticationStatus(true)
                    completion(true, nil)
                }
            }
        }
    }
    
    func saveTokenAndID(_ tokens: [String]?) {
        guard let tok = tokens else { return }
        if tok.count == 2 {
            keychain.set(tok[0], forKey: "authToken")
            keychain.set(tok[1], forKey: "id")
        }
    }
}

