//
//  MapViewController.swift
//  Journal_Codeonly
//
//  Created by wonyoul heo on 5/17/24.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    
    var sampleJournalEntryData = SampleJournalEntryData()
    
    private lazy var mapView: MKMapView = {
        mapView = MKMapView()
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sampleJournalEntryData.createSampleJournalEntryData()
        mapView.addAnnotations(sampleJournalEntryData.journalEntries)

        view.backgroundColor = .white
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        self.navigationItem.title = "Loading..."
        locationManager.requestLocation()
        
        view.addSubview(mapView)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let myCurrentLocation = locations.first {
            let lat = myCurrentLocation.coordinate.latitude
            let long = myCurrentLocation.coordinate.longitude
            
            self.navigationItem.title = "Map"
            mapView.region = setInitialRegion(lat: lat, long: long)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    
    func setInitialRegion(lat: CLLocationDegrees, long: CLLocationDegrees) -> MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long),
                           span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
    
    //MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        let identifier = "mapAnnotation"
        if annotation is JournalEntry {
            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                annotationView.annotation = annotation
                return annotationView
            } else {
                let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView.canShowCallout = true
                let callOutButton = UIButton(type: .detailDisclosure)
                annotationView.rightCalloutAccessoryView = callOutButton
                return annotationView
            }
        } else {
            return nil
        }
    }
}
