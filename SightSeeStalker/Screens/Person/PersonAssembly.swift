//
//  PersonConfigurator.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import UIKit

enum PersonAssembly {
    static func build(person: PersonModel) -> UIViewController {
        let worker = PersonWorker()
        let router = PersonRouter()
        let presenter = PersonPresenter()
        let interactor = PersonInteractor(worker: worker, presenter: presenter, userId: person.id ?? -1)
        let viewController = PersonViewController(interactor: interactor, person: person, router: router)
        

        presenter.viewController = viewController
        router.viewController = viewController

        return viewController
    }
}
