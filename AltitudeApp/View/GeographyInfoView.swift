//
//  GeographyInfoView.swift
//  AltitudeApp
//
//  Created by Şükrü on 8.09.2023.
//

import Foundation
import UIKit

class GeographyInfoView: UIView {
    
    /*
     *  Views
     */
    
    var angleLabel = UILabel()
    
    var directionLabel = UILabel()
    
    var latitudeAndLongitudeLabel = UILabel()
    
    var positionLabel = UILabel()
    
    var altitudeLabel = UILabel()
    
    /*
     *  Override Init
     */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Initialize
        
        self.initialize()
    }
    
    /*
     *  Initialize
     */
    
    func initialize() {
        
        self.backgroundColor = .black
        
        self.prepareDirectionLabel()

        self.prepareAngleLabel()
                
        self.prepareLatitudeAndLongitudeLabel()
        
        self.preparePositionLabel()
        
        self.prepareAltitudeLabel()
        
    }
    
    /*
     *  Prepare Angle Label
     */
    
    func prepareAngleLabel() {
        
        angleLabel.textColor = .white
        angleLabel.font = .systemFont(ofSize: 70, weight: .light)
        angleLabel.textAlignment = .right
        
        self.addSubview(angleLabel)
        
        angleLabel.translatesAutoresizingMaskIntoConstraints = false
        angleLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        angleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        angleLabel.trailingAnchor.constraint(equalTo: directionLabel.leadingAnchor).isActive = true
        
    }

    /*
     *  Prepare Direction Label
     */
    
    func prepareDirectionLabel() {
        
        directionLabel.font = .systemFont(ofSize: 70, weight: .light)
        directionLabel.textColor = .white
        directionLabel.textAlignment = .center
        
        self.addSubview(directionLabel)
        
        directionLabel.translatesAutoresizingMaskIntoConstraints = false
        directionLabel.heightAnchor.constraint(equalToConstant: 83).isActive = true
        directionLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                
        directionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100).isActive = true
        
    }
    
    /*
     *  Prepare Latitude And Longitude Label
     */
    
    func prepareLatitudeAndLongitudeLabel() {
        
        latitudeAndLongitudeLabel.textColor = .white
        latitudeAndLongitudeLabel.font = .systemFont(ofSize: 15, weight: .medium)
        latitudeAndLongitudeLabel.textAlignment = .center
        
        self.addSubview(latitudeAndLongitudeLabel)
        
        latitudeAndLongitudeLabel.translatesAutoresizingMaskIntoConstraints = false
        latitudeAndLongitudeLabel.topAnchor.constraint(equalTo: angleLabel.bottomAnchor, constant: 15).isActive = true
        latitudeAndLongitudeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        latitudeAndLongitudeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }
    
    /*
     *  Prepare Position Label
     */
    
    func preparePositionLabel() {
        
        positionLabel.font = .systemFont(ofSize: 15, weight: .medium)
        positionLabel.textColor = .white
        positionLabel.textAlignment = .center
    
        self.addSubview(positionLabel)
        
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        positionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        positionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        positionLabel.topAnchor.constraint(equalTo: latitudeAndLongitudeLabel.bottomAnchor, constant: 15).isActive = true
        
    }
    
    /*
     *  Prepare Altitude Label
     */
    
    func prepareAltitudeLabel() {
        
        altitudeLabel.textColor = .white
        altitudeLabel.font = .systemFont(ofSize: 15, weight: .medium)
        altitudeLabel.textAlignment = .center
        
        self.addSubview(altitudeLabel)
        
        altitudeLabel.translatesAutoresizingMaskIntoConstraints = false
        altitudeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        altitudeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        altitudeLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 15).isActive = true
        
    }
    
    /*
     *  Required Init
     */
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
