//
//  AuthState.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 06.02.2025.
//

import Foundation

final class AuthState {
    static let shared = AuthState()
    
    private(set) var isAuthenticated: Bool = false
    
    func updateAuthenticationStatus(_ status: Bool) {
        self.isAuthenticated = status
        NotificationCenter.default.post(name: .authStatusChanged, object: nil)
    }
}

extension Notification.Name {
    static let authStatusChanged = Notification.Name("authStatusChanged")
}

