//
//  NewArticlePresenter.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 12.03.2025.
//

import Foundation
import UIKit

final class NewArticlePresenter: NewArticlePresenterProtocol {
    weak var view: NewArticleViewProtocol?
    private let interactor: NewArticleInteractorProtocol
    private let router: NewArticleRouterProtocol

    init(view: NewArticleViewProtocol, interactor: NewArticleInteractorProtocol, router: NewArticleRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func backButtonTapped() {
        router.navigateBack()
    }

    func publishArticle(images: [UIImage], json: [String: Any]) {
        interactor.uploadArticle(images: images, json: json)
    }
}
