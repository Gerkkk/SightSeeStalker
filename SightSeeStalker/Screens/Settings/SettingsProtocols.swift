//
//  SettingsProtocols.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 12.03.2025.
//

import Foundation
import UIKit

protocol SettingsInteractorProtocol {
    func fetchSettings()
    func updateSettings(image: UIImage, json: [String: Any])
}

protocol SettingsPresenterProtocol {
    func didReceiveSettings(_ settings: SettingsModel)
    func navigateBack()
    func viewDidLoad()
    func updateSettings(image: UIImage, json: [String: Any])
}

protocol SettingsViewProtocol: AnyObject {
    func updateSettings(with settings: SettingsModel)
}

protocol SettingsRouterProtocol {
    func navigateBack()
}
