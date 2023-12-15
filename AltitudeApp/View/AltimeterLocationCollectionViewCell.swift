//
//  AltimeterLocationCollectionViewCell.swift
//  AltitudeApp
//
//  Created by Şükrü on 14.09.2023.
//

import UIKit

class AltimeterLocationCollectionViewCell: UICollectionViewCell {
    
    /*
     *  Views
     */
        
    let locationTitleLabel = UILabel()
    
    let locationTitleView = UIView()
    
    let locationLabel = UILabel()
    
    let locationContentView = UIView()
    
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
        
        self.backgroundColor = .orange.withAlphaComponent(0.3)
                        
        self.prepareLocationTitleLabel()
        
        self.prepareLocationLabel()
        
    }
    
    /*
     *  Prepare Location Title Label
     */
    
    func prepareLocationTitleLabel() {
        
        locationTitleView.backgroundColor = .black.withAlphaComponent(0.8)
        locationTitleView.layer.cornerRadius = 10
        
        self.addSubview(locationTitleView)
        
        locationTitleView.translatesAutoresizingMaskIntoConstraints = false
        locationTitleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 7).isActive = true
        locationTitleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7).isActive = true
        locationTitleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -7).isActive = true
        locationTitleView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        locationTitleLabel.text = "Adres"
        locationTitleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        locationTitleLabel.textColor = .white
        locationTitleLabel.textAlignment = .center
        
        locationTitleView.addSubview(locationTitleLabel)
        
        locationTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        locationTitleLabel.centerXAnchor.constraint(equalTo: locationTitleView.centerXAnchor).isActive = true
        locationTitleLabel.centerYAnchor.constraint(equalTo: locationTitleView.centerYAnchor).isActive = true
        
    }
    
    /*
     *  Prepare Location Label
     */
    
    func prepareLocationLabel() {
        
        locationContentView.backgroundColor = .black.withAlphaComponent(0.7)
        locationContentView.layer.cornerRadius = 10
        
        self.addSubview(locationContentView)
        
        locationContentView.translatesAutoresizingMaskIntoConstraints = false
        locationContentView.topAnchor.constraint(equalTo: locationTitleView.bottomAnchor, constant: 7).isActive = true
        locationContentView.leadingAnchor.constraint(equalTo: locationTitleView.leadingAnchor).isActive = true
        locationContentView.trailingAnchor.constraint(equalTo: locationTitleView.trailingAnchor).isActive = true
        locationContentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7).isActive = true
        
        locationLabel.font = .systemFont(ofSize: 13, weight: .medium)
        locationLabel.text = "Cemil meriç mahallesi, Ümraniye, Cemil meriç mahallesi, Ümraniye"
        locationLabel.textColor = .white
        locationLabel.textAlignment = .center
        locationLabel.numberOfLines = 0
        
        locationContentView.addSubview(locationLabel)
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.leadingAnchor.constraint(equalTo: locationContentView.leadingAnchor, constant: 5).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: locationContentView.trailingAnchor, constant: -5).isActive = true
        locationLabel.bottomAnchor.constraint(equalTo: locationContentView.bottomAnchor, constant: -5).isActive = true
        locationLabel.topAnchor.constraint(equalTo: locationContentView.topAnchor, constant: 5).isActive = true
        
    }
    
    /*
     *  Required Init
     */

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
