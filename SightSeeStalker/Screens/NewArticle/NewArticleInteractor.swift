//
//  NewArticleInteractor.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 12.03.2025.
//

import Foundation
import UIKit

final class NewArticleInteractor: NewArticleInteractorProtocol {
    private let worker: NewArticleWorkerProtocol

    init(worker: NewArticleWorkerProtocol) {
        self.worker = worker
    }

    func uploadArticle(images: [UIImage], json: [String: Any]) {
        worker.uploadImagesWithJSON(images: images, json: json)
    }
}
