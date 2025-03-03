//
//  MapViewController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 21.01.2025.
//

import UIKit
import MapKit

class MapViewController: UIViewController, ToggleButtonsViewDelegate {
    var presenter: MapPresenterProtocol!
    
    var buttonsMapType: ToggleButtonsView = ToggleButtonsView(
        titleL: "Visited",
        imageLChosen: UIImage(named: "Check")!,
        imageLNotChosen: UIImage(named: "Location")!,
        titleR: "Planned",
        imageRChosen: UIImage(named: "Check")!,
        imageRNotChosen: UIImage(named: "Location")!,
        imagePadding: 10
    )
    
    private var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundCol
        configureUI()
    }

    func configureUI() {
        view.addSubview(buttonsMapType)
        buttonsMapType.translatesAutoresizingMaskIntoConstraints = false
        buttonsMapType.pinCenterX(to: view)
        buttonsMapType.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 5)
        buttonsMapType.delegate = self
        buttonsMapType.buttonR.layoutIfNeeded()
        
        mapView = MKMapView(frame: view.bounds)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        overrideUserInterfaceStyle = .dark
        mapView.mapType = .mutedStandard
        mapView.pinCenterX(to: view)
        mapView.pinTop(to: view.topAnchor)
        mapView.pinLeft(to: view.leadingAnchor)
        mapView.pinRight(to: view.trailingAnchor)
        mapView.pinBottom(to: view.bottomAnchor)
        mapView.delegate = self
        
        mapView.showsBuildings = false
        view.bringSubviewToFront(buttonsMapType)
        
        presenter.loadSelfArticles()
    }

    func didChangeSelectedButton(isLeftButtonSelected: Bool) {
        mapView.removeAnnotations(mapView.annotations)
        if isLeftButtonSelected {
            presenter.loadSelfArticles()
        } else {
            presenter.loadLiked()
        }
    }
    
    func showAnnotations(_ annotations: [MKAnnotation]) {
        mapView.addAnnotations(annotations)
    }

    func showError(_ error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    func showEndOfListMessage() {
        print("No more articles to load")
    }
}
