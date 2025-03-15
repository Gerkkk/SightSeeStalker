//
//  MapWorker.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import Foundation
import MapKit

class MapWorker: MapWorkerProtocol {
    func loadArticles(url: String, parameters: [String: Any], completion: @escaping (Result<[MKAnnotation], Error>) -> Void) {
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
                    let articlesPage = try decoder.decode(ArticlesModel.self, from: data)
                    
                    var annotations: [MKAnnotation] = []
                    for article in articlesPage.articles {
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2D(latitude: article.coordsN ?? 0, longitude: article.coordsW ?? 0)
                        annotation.title = article.title
                        annotation.subtitle = article.brief
                        annotations.append(annotation)
                    }
                    completion(.success(annotations))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

