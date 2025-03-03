//
//  MapProtocols.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import Foundation
import MapKit

protocol MapPresenterProtocol: AnyObject {
    func loadSelfArticles()
    func loadLiked()
    func handleFetchedAnnotations(_ annotations: [MKAnnotation])
    func handleFetchError(_ error: Error)
}

protocol MapInteractorProtocol: AnyObject {
    func fetchSelfArticles()
    func fetchLikedArticles()
}

protocol MapWorkerProtocol: AnyObject {
    func loadArticles(url: String, parameters: [String: Any], completion: @escaping (Result<[MKAnnotation], Error>) -> Void)
}
