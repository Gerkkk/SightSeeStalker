//
//  NewArticleProtocols.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 12.03.2025.
//

import Foundation
import UIKit

protocol NewArticleViewProtocol: AnyObject {
    func updateView()
}

protocol NewArticlePresenterProtocol: AnyObject {
    func backButtonTapped()
    func publishArticle(images: [UIImage], json: [String: Any])
}

protocol NewArticleInteractorProtocol: AnyObject {
    func uploadArticle(images: [UIImage], json: [String: Any])
}

protocol NewArticleRouterProtocol: AnyObject {
    func navigateBack()
}
