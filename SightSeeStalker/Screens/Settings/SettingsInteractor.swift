//
//  SettingsInteractor.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 12.03.2025.
//

import Foundation
import UIKit
import KeychainSwift


final class SettingsInteractor: SettingsInteractorProtocol {
    weak var presenter: SettingsPresenterProtocol?
    private let worker = SettingsWorker()
    
    func fetchSettings() {
        let kc = KeychainSwift()
        guard let idStr = kc.get("id") else { return }
        guard let id = Int(idStr) else {return}
        
        Task {
            do {
                let settings = try await worker.getUserSettings(id: id)
                
                DispatchQueue.main.async {[weak self] in
                    self?.presenter?.didReceiveSettings(settings)
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func updateSettings(image: UIImage, json: [String: Any]) {
        worker.changeSettings(image: image, json: json)
    }
}
