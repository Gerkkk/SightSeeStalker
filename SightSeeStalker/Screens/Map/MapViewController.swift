//
//  MapViewController.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 21.01.2025.
//

import UIKit
import MapKit

class MapViewController: UIViewController, ToggleButtonsViewDelegate {

    var buttonsMapType: ToggleButtonsView = ToggleButtonsView(titleL: "Visited", imageLChosen: UIImage(named: "Check")!, imageLNotChosen: UIImage(named: "Location")!, titleR: "Planned", imageRChosen: UIImage(named: "Check")!, imageRNotChosen: UIImage(named: "Location")!, imagePadding: 10)
    
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
        
        loadSelfArticles()
    }

    func didChangeSelectedButton(isLeftButtonSelected: Bool) {
        mapView.removeAnnotations(mapView.annotations)
        
        if (isLeftButtonSelected) {
            loadSelfArticles()
        } else {
            loadLiked()
        }
        print(mapView.annotations)
    }
    
    func getURL1() -> URL? {
        URL(string: "http://127.0.0.1:8000/user-actions/get-liked-posts")
    }
    
    func getURL2() -> URL? {
        URL(string: "http://127.0.0.1:8000/user-actions/get-user-posts")
    }
    
    func loadLiked(){
        guard let url = getURL1() else { return }
        //TODO: ADD SELF ID
        let parameters: [String: Any] = [
            "id": 0
        ]
        

        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            var ret: [MKAnnotation] = []
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    var articlesPage: ArticlesModel?
                    
                    articlesPage = try decoder.decode(ArticlesModel.self, from: data)
                    DispatchQueue.main.async {
                        let Articles = articlesPage?.articles ?? []
                        
                        for i in Articles {
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = CLLocationCoordinate2D(latitude: i.coordsN!, longitude: i.coordsW!)
                            annotation.title = i.title
                            annotation.subtitle = i.brief
                            ret.append(annotation)
                        }
                        
                        self?.mapView.addAnnotations(ret)
                    }
                    
                } catch {
                    print("Error decoding response: \(error)")
                }
            }
        }.resume()
    }
    
    func loadSelfArticles(){
        guard let url = getURL2() else { return }
        
        //TODO: ADD SELF ID
        let parameters: [String: Any] = [
            "id": 0
        ]
        

        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            if let error = error {
                print("Error: \(error)")
                
                return
            }
            var ret: [MKAnnotation] = []
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    var articlesPage: ArticlesModel?
                    
                    articlesPage = try decoder.decode(ArticlesModel.self, from: data)
                    
                    DispatchQueue.main.async {
                        let Articles = articlesPage?.articles ?? []
                        print(111, Articles)
                        for i in Articles {
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = CLLocationCoordinate2D(latitude: i.coordsN!, longitude: i.coordsW!)
                            annotation.title = i.title
                            annotation.subtitle = i.brief
                            ret.append(annotation)
                        }
                        
                        self?.mapView.addAnnotations(ret)
                    }
                    
                } catch {
                    print("Error decoding response: \(error)")
                }
            }
        }.resume()
    }
}
