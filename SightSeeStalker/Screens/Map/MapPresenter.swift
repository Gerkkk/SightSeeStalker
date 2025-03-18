//
//  MapPresenter.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 02.03.2025.
//

import MapKit

class MapPresenter: MapPresenterProtocol {
    weak var view: MapViewController?
    var interactor: MapInteractorProtocol?
    
    func loadSelfArticles() {
        interactor?.fetchSelfArticles()
    }
    
    func loadLiked() {
        interactor?.fetchLikedArticles()
    }
    
    func handleFetchedAnnotations(_ annotations: [MKAnnotation]) {
        view?.showAnnotations(annotations)
    }
    
    func handleFetchError(_ error: Error) {
        view?.showError(error)
    }
}
