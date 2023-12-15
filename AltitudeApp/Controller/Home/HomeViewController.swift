//
//  ViewController.swift
//  AltitudeApp
//
//  Created by Şükrü on 20.08.2023.
//

import UIKit
import MapKit
import CoreLocation
import Foundation
import CoreMotion

class HomeViewController: UIViewController {
    
    /*
     *  Views
     */
    lazy var mapView: MKMapView = MKMapView()
    
    let mapTypeView = UIView()
    
    let mapTypeViewLine = UIView()
    
    let mapTypeButton = UIButton(type: .system)
    
    let locationButton = UIButton(type: .system)
    
    lazy var location: CLLocation = CLLocation()
    
    private lazy var userHeading: CLLocationDirection = CLLocationDirection()
    
    private lazy var headingImageView: UIImageView = UIImageView()
    
    lazy var gpsView = GPSSignalView()
    
    lazy var collectionView = CarouselCollectionView(frame: .zero, collectionViewFlowLayout: UICollectionViewFlowLayout())
        
    var compassView = UIView()
    
    var weatherView = UIView()
    
    var weatherIcon = UIImageView()
    
    var weatherDegreeLabel = UILabel()
    
    /*
     *  Vars
     */
    
    var units : AltitudeUnits = .meters
    
    var altitudeText = ""
    
    var accuracyText = ""
    
    var unitsAbbrevText = ""
    
    var barometerText = ""
    
    var addressText = ""
    
    let altimeterManager = CMAltimeter()
    
    var relativeAltitude: Float = 0
        
    var pressure_atm: Float = 0

    /*
     *  Vars
     */
    
    var manager = CLLocationManager()
        
    /*
     *  View Did Load
     */

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    /*
     *  View Did Appear
     */
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.prepareMapViewManager()
     
    }
    
    /*
     *  View Will Disappear
     */
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mapView.mapType = MKMapType.hybrid
        mapView.delegate = nil
        mapView.removeFromSuperview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.initialize()
        
    }
    
    /*
     *  Initialize
     */
    
    func initialize(){
                
        self.view.backgroundColor = .clear
        
        self.prepareMapView()
        
        self.prepareCompassView()

        self.prepareMapTypeView()
        
        self.prepareMapTypeLineView()
        
        self.prepareMapTypeButton()
        
        self.prepareLocationButton()
        
        self.prepareGPSView()
        
        self.prepareWeatherView()
        
        self.prepareWeatherIcon()
        
        self.prepareWeatherDegreeLabel()
        
        self.prepareCollectionView()
        
        self.prepareBarometer()
                
    }
    
    @objc func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        

        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
          
          // Add annotation:
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        
        self.locationManager(manager, didUpdateLocations: [CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)])
        
    }
    
    /*
     *  Prepare Map Type View
     */
    
    func prepareMapTypeView() {
        
        mapTypeView.backgroundColor = .init(hex: "#23282B")
        mapTypeView.layer.cornerRadius = 10
        
        view.addSubview(mapTypeView)
        
        mapTypeView.translatesAutoresizingMaskIntoConstraints = false
        mapTypeView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        mapTypeView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        mapTypeView.centerXAnchor.constraint(equalTo: compassView.centerXAnchor).isActive = true
        mapTypeView.topAnchor.constraint(equalTo: self.compassView.bottomAnchor, constant: 20).isActive = true
    }
    
    /*
     *  Prepare Map Type View Line
     */
    
    func prepareMapTypeLineView() {
        
        mapTypeViewLine.backgroundColor = .init(hex: "#636970")
        
        mapTypeView.addSubview(mapTypeViewLine)
        
        mapTypeViewLine.translatesAutoresizingMaskIntoConstraints = false
        mapTypeViewLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        mapTypeViewLine.centerYAnchor.constraint(equalTo: mapTypeView.centerYAnchor).isActive = true
        mapTypeViewLine.leadingAnchor.constraint(equalTo: mapTypeView.leadingAnchor).isActive = true
        mapTypeViewLine.trailingAnchor.constraint(equalTo: mapTypeView.trailingAnchor).isActive = true
        
    }
    
    /*
     *  Prepare Map Type Button
     */
    
    func prepareMapTypeButton() {
        
        mapTypeButton.setImage(UIImage(systemName: "map"), for: .normal)
        mapTypeButton.addTarget(self, action: #selector(tappedMapType), for: .touchUpInside)
        mapTypeButton.tintColor = .init(hex: "#9FA0A2")
        
        mapTypeView.addSubview(mapTypeButton)
        
        mapTypeButton.translatesAutoresizingMaskIntoConstraints = false
        mapTypeButton.topAnchor.constraint(equalTo: mapTypeView.topAnchor).isActive = true
        mapTypeButton.bottomAnchor.constraint(equalTo: mapTypeViewLine.topAnchor).isActive = true
        mapTypeButton.leadingAnchor.constraint(equalTo: mapTypeView.leadingAnchor).isActive = true
        mapTypeButton.trailingAnchor.constraint(equalTo: mapTypeView.trailingAnchor).isActive = true
        
    }
    
    /*
     *  Prepare Location Button
     */
    
    func prepareLocationButton() {
        
        locationButton.setImage(UIImage(systemName: "location"), for: .normal)
        locationButton.addTarget(self, action: #selector(tappedFocusUserLocation), for: .touchUpInside)
        locationButton.tintColor = .init(hex: "#9FA0A2")
        
        mapTypeView.addSubview(locationButton)
        
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        locationButton.bottomAnchor.constraint(equalTo: mapTypeView.bottomAnchor).isActive = true
        locationButton.topAnchor.constraint(equalTo: mapTypeViewLine.bottomAnchor).isActive = true
        locationButton.leadingAnchor.constraint(equalTo: mapTypeView.leadingAnchor).isActive = true
        locationButton.trailingAnchor.constraint(equalTo: mapTypeView.trailingAnchor).isActive = true
        
    }
    
    /*
     *  Prepare GPS MapView
     */
    
    func prepareGPSView() {
        
        gpsView.backgroundColor = .init(hex: "#23282B")
        
        view.addSubview(gpsView)
        
        gpsView.translatesAutoresizingMaskIntoConstraints = false
        gpsView.widthAnchor.constraint(equalToConstant: 67).isActive = true
        gpsView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        gpsView.centerYAnchor.constraint(equalTo: compassView.centerYAnchor).isActive = true
        gpsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
    }
    
    /*
     *  Prepare Compass View
     */
    
    func prepareCompassView() {
        
        compassView.backgroundColor = .init(hex: "#23282B")
        compassView.layer.cornerRadius = 30
        compassView.isUserInteractionEnabled = true
        compassView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedCompass)))
        
        view.addSubview(compassView)
        
        compassView.translatesAutoresizingMaskIntoConstraints = false
        compassView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        compassView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        compassView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        compassView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        
        let compassImageView = UIImageView()
        compassImageView.image = UIImage(named: "compassIcon")?.withRenderingMode(.alwaysTemplate)
        compassImageView.tintColor = .systemOrange
        compassImageView.isUserInteractionEnabled = true
        compassImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedCompass)))
        
        compassView.addSubview(compassImageView)
        
        compassImageView.translatesAutoresizingMaskIntoConstraints = false
        compassImageView.topAnchor.constraint(equalTo: compassView.topAnchor, constant: 10).isActive = true
        compassImageView.bottomAnchor.constraint(equalTo: compassView.bottomAnchor, constant: -10).isActive = true
        compassImageView.leadingAnchor.constraint(equalTo: compassView.leadingAnchor, constant: 10).isActive = true
        compassImageView.trailingAnchor.constraint(equalTo: compassView.trailingAnchor, constant: -10).isActive = true
        
    }
    
    /*
     *  Tapped Compass
     */
    
    @objc func tappedCompass() {
        
        let compassVC = CompassViewController()
        
        compassVC.modalPresentationStyle = .overFullScreen

        self.present(compassVC, animated: true)
        
    }
    
    /*
     *  Tapped Map Type
     */
    
    @objc func tappedMapType() {
        
        let vc = MapTypeViewController()
        
        vc.selectMapTypeHandler = { selectType in
                        
            switch selectType {
                
            case .SATELLITE:
                self.mapView.mapType = .satellite
            default:
                self.mapView.mapType = .standard
            }
            
        }
        
        self.sheetPresentationController(viewController: vc, height: 350, isDefaultMedium: true)
                
    }
    
    /*
     *  Tapped Focus User Location
     */
    
    @objc func tappedFocusUserLocation() {
        
        mapView.setCenter(mapView.userLocation.coordinate, animated: true)
        
    }
    
}

