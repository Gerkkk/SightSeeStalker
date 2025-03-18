//
//  MapViewController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 21.01.2025.
//

import UIKit
import MapKit

class MapViewController: UIViewController, ToggleButtonsViewDelegate {
    var presenter: MapPresenterProtocol?
    
    private enum Constants {
        static let placeHolderText = "Enter text"
        static let leftButtonText = "Visited"
        static let rightButtonText = "Planned"
        static let imageChosen = UIImage(named: "Check")!
        static let imageLNotChosen = UIImage(named: "Location")!
        static let imageRNotChosen = UIImage(named: "Location")!
        static let imagePadding = CGFloat(10)
        static let mapTopOffset = CGFloat(5)
    }
    
    var buttonsMapType: ToggleButtonsView = ToggleButtonsView(
        titleL: Constants.leftButtonText,
        imageLChosen: Constants.imageChosen,
        imageLNotChosen: Constants.imageLNotChosen,
        titleR: Constants.rightButtonText,
        imageRChosen: Constants.imageChosen,
        imageRNotChosen: Constants.imageRNotChosen,
        imagePadding: Constants.imagePadding
    )
    
    private var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundCol
        configureUI()
    }

    func configureUI() {
        self.configureButtonsToggle()
        self.configureMapView()
        
        view.bringSubviewToFront(buttonsMapType)
    
        presenter?.loadSelfArticles()
    }
    
    private func configureButtonsToggle() {
        view.addSubview(buttonsMapType)
        buttonsMapType.translatesAutoresizingMaskIntoConstraints = false
        buttonsMapType.pinCenterX(to: view)
        buttonsMapType.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.mapTopOffset)
        buttonsMapType.delegate = self
        buttonsMapType.buttonR.layoutIfNeeded()
    }
    
    private func configureMapView() {
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
    }

    func didChangeSelectedButton(isLeftButtonSelected: Bool) {
        mapView.removeAnnotations(mapView.annotations)
        if isLeftButtonSelected {
            presenter?.loadSelfArticles()
        } else {
            presenter?.loadLiked()
        }
    }
    
    func showAnnotations(_ annotations: [MKAnnotation]) {
        mapView.addAnnotations(annotations)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.removeAnnotations(mapView.annotations)
        if buttonsMapType.isLeftButtonSelected {
            presenter?.loadSelfArticles()
        } else {
            presenter?.loadLiked()
        }
    }

    func showError(_ error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    func showEndOfListMessage() {
        print("No more articles to load")
    }
}
