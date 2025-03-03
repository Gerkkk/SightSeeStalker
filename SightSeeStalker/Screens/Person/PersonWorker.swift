//
//  PersonWorker.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import Foundation

final class PersonWorker {
    private let baseURL = Config.baseURL

    func fetchUserPosts(userId: Int, completion: @escaping (Result<[ArticleModel], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/user-actions/get-user-posts") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }

        let parameters: [String: Any] = ["id": userId]

        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            completion(.failure(NSError(domain: "Invalid Parameters", code: 0)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let articlesPage = try decoder.decode(ArticlesModel.self, from: data)
                completion(.success(articlesPage.articles))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
