//
//  SettingsAssembly.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 12.03.2025.
//

import Foundation

import UIKit

final class SettingsAssembly {
    static func build() -> UIViewController {
        let view = SettingsViewController()
        //TODO: userid
        let interactor = SettingsInteractor()
        let router = SettingsRouter()
        let presenter = SettingsPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
