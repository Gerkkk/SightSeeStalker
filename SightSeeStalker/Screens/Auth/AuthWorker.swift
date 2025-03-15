//
//  AuthWorker.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 15.03.2025.
//

import Foundation

class AuthWorker {
    func login(url: String, parameters: [String: Any], completion: @escaping (Result<LogInResponseModel, Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let retData = try decoder.decode(LogInResponseModel.self, from: data)
                    completion(.success(retData))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
