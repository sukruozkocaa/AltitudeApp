//
//  MapTypeViewController.swift
//  AltitudeApp
//
//  Created by Şükrü on 6.09.2023.
//

import UIKit
import MapKit

enum SelectMapType: String { case SATELLITE, DISCOVER }

class MapTypeViewController: UIViewController {

    /*
     *  Views
     */
    
    let exitButton = UIButton()
    
    let titleLabel = UILabel()
    
    let satelliteMapView = UIImageView()
    
    let discoverMapView = UIImageView()
        
    /*
     *  Vars
     */
    
    var selectMapTypeHandler: ((SelectMapType) -> Void)? = nil
    
    /*
     *  View Did Load
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
        
        self.prepareExitButton()
        
        self.prepareTitleLabel()
        
        self.prepareSatelliteMapView()
        
        self.prepareDiscoverMapView()
        
    }
    
    /*
     *  Prepare Title Label
     */
    
    func prepareTitleLabel() {
        
        titleLabel.text = "Harita Seçin"
        titleLabel.textColor = .init(hex: "#FFFFFF")
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints                                    = false
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive         = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
    }
    
    /*
     *  Prepare Satellite Map View
     */
    
    func prepareSatelliteMapView() {
        
        satelliteMapView.image = UIImage(named: "mapImage2")
        satelliteMapView.contentMode = .scaleAspectFill
        satelliteMapView.backgroundColor = .yellow
        satelliteMapView.layer.cornerRadius = 8
        satelliteMapView.layer.masksToBounds = true
        satelliteMapView.isUserInteractionEnabled = true
        
        satelliteMapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedSatelliteMap)))
        
        view.addSubview(satelliteMapView)
        
        satelliteMapView.translatesAutoresizingMaskIntoConstraints = false
        satelliteMapView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        satelliteMapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive  = true
        satelliteMapView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        satelliteMapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        let blurView = UIView()
        
        blurView.backgroundColor = .black
        blurView.layer.opacity = 0.5
        blurView.layer.masksToBounds = true
        blurView.clipsToBounds = true
        
        satelliteMapView.addSubview(blurView)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        blurView.bottomAnchor.constraint(equalTo: satelliteMapView.bottomAnchor).isActive = true
        blurView.leadingAnchor.constraint(equalTo: satelliteMapView.leadingAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: satelliteMapView.trailingAnchor).isActive = true
        
        let titleLabel = UILabel()
        
        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.text = "Uydu Görünümü"
        titleLabel.textAlignment = .center
        
        satelliteMapView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: blurView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: blurView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: blurView.trailingAnchor).isActive = true
        
    }
    
    /*
     *  Prepare Discover Map View
     */
    
    func prepareDiscoverMapView() {
        
        discoverMapView.image = UIImage(named: "mapImage")
        discoverMapView.contentMode = .scaleAspectFill
        discoverMapView.backgroundColor = .orange
        discoverMapView.layer.cornerRadius = 8
        discoverMapView.layer.masksToBounds = true
        discoverMapView.isUserInteractionEnabled = true
        
        discoverMapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedDiscoverMap)))
        
        view.addSubview(discoverMapView)
        
        discoverMapView.translatesAutoresizingMaskIntoConstraints = false
        discoverMapView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        discoverMapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        discoverMapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        discoverMapView.topAnchor.constraint(equalTo: satelliteMapView.bottomAnchor, constant: 20).isActive = true
        
        let blurView = UIView()
        
        blurView.backgroundColor = .black
        blurView.layer.opacity = 0.5
        blurView.layer.masksToBounds = true
        blurView.clipsToBounds = true
        
        discoverMapView.addSubview(blurView)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        blurView.bottomAnchor.constraint(equalTo: discoverMapView.bottomAnchor).isActive = true
        blurView.leadingAnchor.constraint(equalTo: discoverMapView.leadingAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: discoverMapView.trailingAnchor).isActive = true
        
        let titleLabel = UILabel()
        
        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.text = "Harita Görünümü"
        titleLabel.textAlignment = .center
        
        discoverMapView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: blurView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: blurView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: blurView.trailingAnchor).isActive = true
        
    }
    
    /*
     *  Prepare Exit Button
     */
    
    func prepareExitButton() {
        
        exitButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        exitButton.tintColor = .init(hex: "#FFFFFF")
        exitButton.addTarget(self, action: #selector(tappedExit), for: .touchUpInside)
        
        view.addSubview(exitButton)
        
        exitButton.translatesAutoresizingMaskIntoConstraints                                       = false
        exitButton.widthAnchor.constraint(equalToConstant: 20).isActive                            = true
        exitButton.heightAnchor.constraint(equalToConstant: 20).isActive                           = true
        exitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive            = true
        exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
    }
    
    /*
     *  Tapped Discover Map
     */
    
    @objc func tappedDiscoverMap() {
        satelliteMapView.layer.borderWidth = 0
        discoverMapView.layer.borderWidth = 2
        discoverMapView.layer.borderColor = UIColor.blue.cgColor
                
        self.selectMapTypeHandler?(.DISCOVER)
        
        self.dismiss(animated: true)
        
    }
    
    /*
     *  Tapped Satellite Map
     */
    
    @objc func tappedSatelliteMap() {
        discoverMapView.layer.borderWidth = 0
        satelliteMapView.layer.borderWidth = 2
        satelliteMapView.layer.borderColor = UIColor.blue.cgColor
        
        self.selectMapTypeHandler?(.SATELLITE)
        
        self.dismiss(animated: true)
    }
    
    /*
     *  Tapped Exit
     */
    
    @objc func tappedExit() {
        
        self.dismiss(animated: true)
        
    }

}


