//
//  HomeViewController + User Location.swift
//  AltitudeApp
//
//  Created by Şükrü on 6.09.2023.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

enum AltitudeUnits {
    case meters
    case feet
}

extension CLLocationSpeed
{
    var kph     : CDouble { return (self * 3.6) }
    var knots   : CDouble { return (self * 1.943_844) }
    var fts     : CDouble { return (self * 3.280_840) }
    var mph     : CDouble { return (self * 2.236_936) }
};

extension HomeViewController {
    
    /*
     *  Prepare Map View
     */
    
    func prepareMapView() {
        
        mapView = MKMapView()
        mapView.mapType = .hybrid
        mapView.isUserInteractionEnabled = true
        mapView.showsUserLocation = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        mapView.addGestureRecognizer(gesture)
        
        view.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
     
    }
    
    /*
     *  Prepare Map View Manager
     */
    
    func prepareMapViewManager() {
    
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.distanceFilter = kCLDistanceFilterNone
        manager.pausesLocationUpdatesAutomatically = true
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    /*
     *  Render
     */
    
    func render(_ location: CLLocation) {
    
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        
        self.gpsView.configureGPS(horizontalAccuracy: location.horizontalAccuracy)
                
    }
    
    func update(altitude: Int, accuracy: Int, units: AltitudeUnits) {
        let unitsAbbrev : String = units == .feet ? "ft" : "m"
        self.altitudeText = "\(altitude)"
        self.accuracyText =  "\(accuracy)"
        self.unitsAbbrevText = "\(unitsAbbrev)"
        self.collectionView.reloadData()
    }
    
    func changeUnits() {
        switch units {
        case .meters: units = .feet
        case .feet: units = .meters
        }
        
        let lastLocation = location
        locationManager(self.manager, didUpdateLocations: [lastLocation])        
    }
    
}

extension HomeViewController: CLLocationManagerDelegate {
    
    // Did Update Locations
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                        
        if let location = locations.first {
                
            self.location = location
                                    
            manager.stopUpdatingLocation()
                    
            render(location)
            
            self.fetchWeather(location: location)
            
            let geocoder = CLGeocoder()
            
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                
                if error != nil {
                    return
                }
                
                let placemark = placemarks!
                
                if placemark.count > 0 {
                    
                    let placemark = placemarks![0]
                    
                    let locality = placemark.locality
                                        
                    let administrativeArea = placemark.administrativeArea
                                        
                    let country = placemark.country
                                                        
                    self.addressText = "\(locality ?? ""),\(administrativeArea ?? ""), \(country ?? "")"
                    
                }
                
            }
            
            if let altitude = locations.last?.altitude,
                let accuracy = locations.last?.verticalAccuracy {
                
                let convertedAltitude : Int
                let convertedAccuracy : Int
                
                if units == .feet {
                    convertedAltitude = Int(round(altitude * 3.28084))
                    convertedAccuracy = Int(round(accuracy * 3.28084))
                }
                
                else {
                    convertedAltitude = Int(round(altitude))
                    convertedAccuracy = Int(round(accuracy))
                }
        
                self.update(altitude: convertedAltitude, accuracy: convertedAccuracy, units: units)
                
            }
            
            self.collectionView.reloadData()
        }
    }
}
