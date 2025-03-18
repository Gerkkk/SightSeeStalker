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
            guard let boundData = "--\(boundary)\r\n".data(using: .utf8) else {return}
            body.append(boundData)
            guard let contDispos = "Content-Disposition: form-data; name=\"json\"; filename=\"article.json\"\r\n".data(using: .utf8) else {return}
            body.append(contDispos)
            guard let contType = "Content-Type: application/json\r\n\r\n".data(using: .utf8) else {return}
            body.append(contType)
            body.append(jsonData)
            guard let ending = "\r\n".data(using: .utf8) else {return}
            body.append(ending)
        }

        for (index, image) in images.enumerated() {
            if let imageData = image.jpegData(compressionQuality: 0.8) {
                guard let bound = "--\(boundary)\r\n".data(using: .utf8) else {return}
                body.append(bound)
                guard let contDisp = "Content-Disposition: form-data; name=\"images\"; filename=\"image\(index).jpg\"\r\n".data(using: .utf8) else {return}
                body.append(contDisp)
                guard let contType = "Content-Type: image/jpeg\r\n\r\n".data(using: .utf8) else {return}
                body.append(contType )
                body.append(imageData)
                guard let rn = "\r\n".data(using: .utf8) else {return}
                body.append(rn)
            }
        }
        
        guard let ending = "--\(boundary)--\r\n".data(using: .utf8) else {return}
        body.append(ending)
        request.httpBody = body

        URLSession.shared.dataTask(with: request).resume()
    }
}
