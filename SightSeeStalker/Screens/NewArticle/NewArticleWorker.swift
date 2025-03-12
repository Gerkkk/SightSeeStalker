//
//  NewArticleWorker.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 12.03.2025.
//

import Foundation
import UIKit

protocol NewArticleWorkerProtocol: AnyObject {
    func uploadImagesWithJSON(images: [UIImage], json: [String: Any])
}

final class NewArticleWorker: NewArticleWorkerProtocol {
    func uploadImagesWithJSON(images: [UIImage], json: [String: Any]) {
        guard let url = URL(string: Config.baseURL + "/user-actions/create-new-article") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()

        if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"json\"; filename=\"article.json\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: application/json\r\n\r\n".data(using: .utf8)!)
            body.append(jsonData)
            body.append("\r\n".data(using: .utf8)!)
        }

        for (index, image) in images.enumerated() {
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"images\"; filename=\"image\(index).jpg\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
                body.append(imageData)
                body.append("\r\n".data(using: .utf8)!)
            }
        }

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body

        URLSession.shared.dataTask(with: request).resume()
    }
}
