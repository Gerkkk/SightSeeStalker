//
//  SettingsInteractor.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 12.03.2025.
//

import Foundation
import UIKit


final class SettingsInteractor: SettingsInteractorProtocol {
    var presenter: SettingsPresenterProtocol?
    private let worker = SettingsWorker()
    
    func fetchSettings() {
        Task {
            do {
                let settings = try await worker.getUserSettings(id: 0)
                
                DispatchQueue.main.async {[weak self] in
                    self?.presenter?.didReceiveSettings(settings)
                }
            } catch {
                print("Ошибка: \(error)")
            }
        }
    }
    
    func updateSettings(image: UIImage, json: [String: Any]) {
        worker.changeSettings(image: image, json: json)
    }
}
