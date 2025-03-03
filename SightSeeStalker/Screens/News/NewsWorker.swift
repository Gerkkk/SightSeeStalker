//
//  NewsWorker.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import Foundation

protocol NewsWorkerProtocol {
    func fetchNews(parameters: [String: Any], completion: @escaping (Result<[ArticleModel], Error>) -> Void)
}

final class NewsWorker: NewsWorkerProtocol {
    private let baseURL = Config.baseURL
    
    func fetchNews(parameters: [String: Any], completion: @escaping (Result<[ArticleModel], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/user-actions/fetch-news") else { return }
        
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
                    completion(.failure(NSError(domain: "No data", code: -1)))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let articlesPage = try decoder.decode(ArticlesModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(articlesPage.articles))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

