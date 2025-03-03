//
//  ExploreWorker.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import Foundation

class ExploreWorker: ExploreWorkerProtocol {
    
    func fetchSearchResults(query: String, searchType searchtype: Int, completion: @escaping (Result<ExploreDataModel, Error>) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8000/user-actions/fetch-search-results") else {
            return
        }
        
        let parameters: [String: Any] = [
            "user_id": 0, // Fix this later
            "search_field_string": query,
            "searching_type": searchtype
        ]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "DataError", code: 0, userInfo: nil)))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(ExploreDataModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

