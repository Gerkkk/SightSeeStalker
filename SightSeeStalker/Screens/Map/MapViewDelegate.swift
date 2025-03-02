//
//  MapViewDelegate.swift
//  SightSeeStalker
//
//  Created by Danya Polyakov on 17.02.2025.
//

import UIKit
import MapKit


// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }

        let identifier = "CustomAnnotationView"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? CustomAnnotationView

        if annotationView == nil {
            annotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
            annotationView?.canShowCallout = true
        }

        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotationView: MKAnnotationView) {
        if let customAnnotationView = annotationView as? CustomAnnotationView {
            customAnnotationView.isSelected = true
            customAnnotationView.layoutSubviews() // Принудительная перерисовка
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect annotationView: MKAnnotationView) {
        if let customAnnotationView = annotationView as? CustomAnnotationView {
            customAnnotationView.isSelected = false
            customAnnotationView.layoutSubviews()
        }
    }



}
