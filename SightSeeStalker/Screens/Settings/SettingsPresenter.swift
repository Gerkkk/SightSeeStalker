//
//  SettingsPresenter.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 12.03.2025.
//

import Foundation
import UIKit

//final class SettingsPresenter: SettingsPresenterProtocol {
//    weak var view: SettingsViewProtocol?
//    var interactor: SettingsInteractorProtocol?
//    var router: SettingsRouterProtocol?
//    
//    func didReceiveSettings(_ settings: SettingsModel) {
//        view?.updateUI(with: settings)
//    }
//}

final class SettingsPresenter: SettingsPresenterProtocol {
    weak var view: SettingsViewProtocol?
    var interactor: SettingsInteractorProtocol
    var router: SettingsRouterProtocol
    
    init(view: SettingsViewProtocol, interactor: SettingsInteractorProtocol, router: SettingsRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func didReceiveSettings(_ settings: SettingsModel) {
        view?.updateSettings(with: settings)
    }
    
    func updateSettings(image: UIImage, json: [String: Any]) {
        interactor.updateSettings(image: image, json: json)
    }
    
    func viewDidLoad() {
        Task {
            interactor.fetchSettings()
        }
    }
    
    func navigateBack() {
        router.navigateBack()
    }
}
