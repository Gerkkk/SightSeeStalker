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

        let identifier = "customPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView

        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.markerTintColor = UIColor.customGreen
            annotationView?.glyphText = "S"
            annotationView?.tintColor = UIColor.textSupporting
        } else {
            annotationView?.annotation = annotation
            annotationView?.canShowCallout = true
            annotationView?.markerTintColor = UIColor.customGreen
            annotationView?.glyphText = "S"
            annotationView?.tintColor = UIColor.textSupporting
        }

        return annotationView
    }
}
