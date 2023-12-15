//
//  DenemeViewController.swift
//  AltitudeApp
//
//  Created by Şükrü on 8.09.2023.
//

import UIKit
import CoreLocation
import Contacts

class CompassViewController: UIViewController {

    /*
     *  Views
     */
    
    private lazy var degreeScaleView = DegreeScaleView()

    private lazy var geographyInfoView = GeographyInfoView()
    
    /*
     *  Vars
     */
    
    private lazy var locationManager : CLLocationManager = CLLocationManager()
    
    private lazy var currLocation: CLLocation = CLLocation()
        
    var navigationBarView = UIView()
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
     
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.view.backgroundColor = .black
                
    }
    
    /*
     * View Did Load
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Initialize
        
        self.initialize()
    
    }
    
    /*
     *  Initialize
     */
    
    func initialize() {
        
        view.backgroundColor = .black
        
        self.prepareBackIcon()
                
        self.prepareDScaView()
        
        self.prepareGeographyInfoView()
        
        self.prepareLocationManager()
        
    }
    
    /*
     *  Prepare Back Icon
     */
    
    func prepareBackIcon() {
        
        let backButton = UIImageView()
        
        backButton.image = UIImage(named: "backIcon")?.withRenderingMode(.alwaysTemplate)
        backButton.tintColor = .white
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedDismiss)))
        
        view.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.widthAnchor.constraint(equalToConstant: 11).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
    }
    
    /*
     *  Tapped Dismiss
     */
    
    @objc func tappedDismiss() {
        self.dismiss(animated: true)
    }
    
    /*
     *  Prepaer DScaView
     */
    
    func prepareDScaView() {
        
        degreeScaleView = DegreeScaleView(frame: CGRect(x: 0, y: 123, width: screenW, height: screenW))
        
        degreeScaleView.backgroundColor = .black
        
        self.view.addSubview(degreeScaleView)
        
    }
    
    /*
     *  Prepare Geography Info View
     */
    
    func prepareGeographyInfoView() {
        
        geographyInfoView.frame = CGRect(x: 0, y: 617, width: screenW, height: 165)
        
        self.view.addSubview(geographyInfoView)
                
    }
    
    /*
     *  Prepare Location Manager
     */
    
    func prepareLocationManager() {
        
        locationManager.delegate = self
        locationManager.distanceFilter = 0
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        
        if CLLocationManager.locationServicesEnabled() && CLLocationManager.headingAvailable() {
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
        }else {
            print("error")
        }
        
    }

}

extension CompassViewController: CLLocationManagerDelegate {
    
    // Did Update Locations
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        currLocation = locations.last!
        
        let longitudeStr = String(format: "%3.4f", currLocation.coordinate.longitude)
        
        let latitudeStr = String(format: "%3.4f", currLocation.coordinate.latitude)
        
        let altitudeStr = "\(Int(currLocation.altitude))"
        
        let newLongitudeStr = longitudeStr.DegreeToString(d: Double(longitudeStr)!)
        
        let newlatitudeStr = latitudeStr.DegreeToString(d: Double(latitudeStr)!)

        geographyInfoView.latitudeAndLongitudeLabel.text = "\(newlatitudeStr)  \(newLongitudeStr)"
        geographyInfoView.altitudeLabel.text = "Yükseklik: \(altitudeStr) m"
        
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(currLocation) { (placemarks, error) in

            guard let placeM = placemarks else { return }

            guard placeM.count > 0 else { return }

            let placemark: CLPlacemark = placeM[0]

            let addressDictionary = placemark.postalAddress

            guard let country = addressDictionary?.country else { return }

            guard let province = addressDictionary?.city else { return }
            
            guard let district = addressDictionary?.state else { return }

            self.geographyInfoView.positionLabel.text = "\(country)\(", ")\(province)\(", ")\(district)"
        }
 
    }
    
    // Did Update Heading

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {

        let device = UIDevice.current
        
        if newHeading.headingAccuracy > 0 {
            
            let magneticHeading: Float = heading(Float(newHeading.magneticHeading), fromOrirntation: device.orientation)
            
            let headi: Float = -1.0 * Float.pi * Float(newHeading.magneticHeading) / 180.0

            geographyInfoView.angleLabel.text = "\(Int(magneticHeading))°"
            
            degreeScaleView.resetDirection(CGFloat(headi))
            
            update(newHeading)
        }
    }
   
    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return true
    }
    
}

extension CompassViewController {

    // Update Geography Info View
    
    private func update(_ newHeading: CLHeading) {
        
        let theHeading: CLLocationDirection = newHeading.magneticHeading > 0 ? newHeading.magneticHeading : newHeading.trueHeading
        
        let angle = Int(theHeading)
        
        switch angle {
        case 0:
            geographyInfoView.directionLabel.text = "K"
        case 90:
            geographyInfoView.directionLabel.text = "D"
        case 180:
            geographyInfoView.directionLabel.text = "G"
        case 270:
            geographyInfoView.directionLabel.text = "B"
        default:
            break
        }
        
        if angle > 0 && angle <= 22 {
            geographyInfoView.directionLabel.text = "K"
        }
        
        if angle > 22 && angle <= 67 {
            geographyInfoView.directionLabel.text = "KD"
        }
        
        if angle > 67 && angle <= 112 {
            geographyInfoView.directionLabel.text = "D"
        }
        
        if angle > 112 && angle <= 157 {
            geographyInfoView.directionLabel.text = "GD"
        }
        
        if angle > 157 && angle <= 202 {
            geographyInfoView.directionLabel.text = "G"
        }
        
        if angle > 202 && angle <= 247 {
            geographyInfoView.directionLabel.text = "GB"
        }
        
        if angle > 247 && angle <= 292 {
            geographyInfoView.directionLabel.text = "B"
        }
        
        if angle > 292 && angle <= 337 {
            geographyInfoView.directionLabel.text = "KB"
        }
        
        if angle > 337 && angle <= 359 {
            geographyInfoView.directionLabel.text = "K"
        }
    }

    private func heading(_ heading: Float, fromOrirntation orientation: UIDeviceOrientation) -> Float {
        
        var realHeading: Float = heading
        
        switch orientation {
        case .portrait:
            break
        case .portraitUpsideDown:
            realHeading = heading - 180
        case .landscapeLeft:
            realHeading = heading + 90
        case .landscapeRight:
            realHeading = heading - 90
        default:
            break
        }
        if realHeading > 360 {
            realHeading -= 360
        }else if realHeading < 0.0 {
            realHeading += 366
        }
        return realHeading
    }
}

