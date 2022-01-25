//
//  ExploringVC.swift
//  Ostracon
//
//  Created by Abdullah AlRashoudi on 1/10/22.
//

import UIKit
import MapKit
import CoreLocation

class ExploringVC: UIViewController, CLLocationManagerDelegate {
    var mapView: MKMapView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(MKMapView())
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        title = "Exploring"
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor),
            mapView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            render(location)
        }
    }
    
    func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        // (26.3354262, 50.1209593)
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: 26.3354262, longitude: 50.1209593)
        pin.title = "King Abdulaziz Center for World Culture - Ithra"
        mapView.addAnnotation(pin)
        
        // (24.6310391, 46.7134817)
        let pin1 = MKPointAnnotation()
        pin1.coordinate = CLLocationCoordinate2D(latitude: 24.6310391, longitude: 46.7134817)
        pin1.title = "Al Masmak Palace Museum"
        mapView.addAnnotation(pin1)
        
        // (24.6475544, 46.7103484)
        let pin2 = MKPointAnnotation()
        pin2.coordinate = CLLocationCoordinate2D(latitude: 24.6475544, longitude: 46.7103484)
        pin2.title = "The Saudi National Museum"
        mapView.addAnnotation(pin2)
    }
}
