//
//  HomeWorker.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import UIKit

final class HomeWorker: HomeWorkerProtocol {
    private func getURL(endpoint: String) -> URL? {
        return URL(string: "http://127.0.0.1:8000/user-actions/" + endpoint)
    }
    
    func getUserInfo(id: Int, completion: @escaping (Result<PersonModel, Error>) -> Void) {
        guard let url = getURL(endpoint: "get-user-info") else { return }
        let parameters: [String: Any] = ["id": id]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                DispatchQueue.main.async() {
                    completion(.failure(error))
                    return
                }
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let userInfo = try decoder.decode(PersonResponse.self, from: data)
                    DispatchQueue.main.async() {
                        completion(.success(userInfo.user))
                    }
                } catch {
                    DispatchQueue.main.async() {
                        completion(.failure(error))
                    }
                }
            }
        }.resume()
    }
    
    func getUserPosts(id: Int, completion: @escaping (Result<[ArticleModel], Error>) -> Void) {
        guard let url = getURL(endpoint: "get-user-posts") else { return }
        let parameters: [String: Any] = ["id": id]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                DispatchQueue.main.async() {
                    completion(.failure(error))
                }
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let articlesPage = try decoder.decode(ArticlesModel.self, from: data)
                    
                    DispatchQueue.main.async() {
                        completion(.success(articlesPage.articles))
                    }
                } catch {
                    DispatchQueue.main.async() {
                        completion(.failure(error))
                    }
                }
            }
        }.resume()
    }
}
