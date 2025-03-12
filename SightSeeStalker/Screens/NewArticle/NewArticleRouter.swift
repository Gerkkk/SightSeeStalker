//
//  NewArticleRouter.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 12.03.2025.
//

import Foundation
import UIKit

final class NewArticleRouter: NewArticleRouterProtocol {
    weak var viewController: UIViewController?

    func navigateBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
