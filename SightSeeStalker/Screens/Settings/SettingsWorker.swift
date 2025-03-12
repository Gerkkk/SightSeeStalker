//
//  SettingsWorker.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 12.03.2025.
//

import Foundation
import UIKit

final class SettingsWorker {
    func getUserSettings(id: Int) async throws -> SettingsModel {
        guard let url = URL(string: Config.baseURL + "/user-actions/get-settings") else {
            throw URLError(.badURL)
        }
        let parameters: [String: Any] = ["id": id]
        let httpBody = try JSONSerialization.data(withJSONObject: parameters)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        let response = try decoder.decode(SettingsResponse.self, from: data)
        return response.user
    }
    
    func changeSettings(image: UIImage, json: [String: Any]) {
        let url = URL(string: Config.baseURL + "/user-actions/change-settings")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        var body = Data()
        if let jsonData = try? JSONSerialization.data(withJSONObject: json) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"json\"; filename=\"settings.json\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: application/json\r\n\r\n".data(using: .utf8)!)
            body.append(jsonData)
            body.append("\r\n".data(using: .utf8)!)
        }
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"avatar\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error { print("Ошибка: \(error.localizedDescription)") }
        }.resume()
    }
}
