//
//  MapAssembly.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import Foundation
import UIKit

enum MapAssembly {
    static func build() -> UIViewController {
        let viewController = MapViewController()
        let presenter = MapPresenter()
        let interactor = MapInteractor(worker: MapWorker())

        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        interactor.presenter = presenter

        return viewController
    }
}
