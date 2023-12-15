//
//  AltimeterCollectionViewCell.swift
//  AltitudeApp
//
//  Created by Şükrü on 10.09.2023.
//

import UIKit
import CoreLocation

class AltimeterCoordinateCollectionViewCell: UICollectionViewCell {
    
    let altitudeLabel = UILabel()
    
    let accuracyLabel = UILabel()
    
    let unitsAbbrevLabel = UILabel()
    
    let barometerTitleLabel = UILabel()
    
    let barometerLabel = UILabel()
    
    let blurBGView = UIView()
    
    var altitudeTappedHandler: (() -> Void)?
    
    var coordinateTappedHandler: (() -> Void)?
    
    var altitudeView = UIView()
    
    var altitudeUnitLabel = UILabel()
    
    var altitudeApproximateLabel = UILabel()
    
    var coordinateTitleLabel = UILabel()

    var coordinateLabel = UILabel()

    var barometerTitleView = UIView()
    
    var coordinateTitleView = UIView()
    
    var barometerContentView = UIView()
    
    var coordinateContentView = UIView()
    
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
      //  self.prepareBlurView()
        self.prepareAltitudeView()
        self.prepareAltitudeLabel()
        self.prepareAltitudeUnitLabel()
        self.prepareAltitudeApproximateLabel()
        self.prepareBarometerTitle()
        self.prepareBarometerLabel()
        self.prepareCoordinateTitleLabel()
        self.prepareCoordinateLabel()
    }
    
    /*
     *  Prepare BlurView
     */
    
    func prepareBlurView() {
        blurBGView.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: self.contentView.frame.height)
        blurBGView.backgroundColor = .clear
        blurBGView.layer.cornerRadius = 15
        blurBGView.layer.masksToBounds = true
        
        contentView.addSubview(blurBGView)
        
        let darkBlur = UIBlurEffect(style: .prominent)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.layer.cornerRadius = 15
        blurView.frame = blurBGView.bounds
        blurBGView.addSubview(blurView)
    }
    
    /*
     *  Prepare Altitude View
     */
    
    func prepareAltitudeView() {
        
        altitudeView.layer.cornerRadius = 18
        altitudeView.backgroundColor = .black.withAlphaComponent(0.8)
        altitudeView.isUserInteractionEnabled = true
        altitudeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedAltitude)))
        
        addSubview(altitudeView)
        
        altitudeView.translatesAutoresizingMaskIntoConstraints = false
        altitudeView.topAnchor.constraint(equalTo: self.topAnchor, constant: 7).isActive = true
        altitudeView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7).isActive = true
        altitudeView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7).isActive = true
        
    }
    
    /*
     *  Prepare Altitude Label
     */
    
    func prepareAltitudeLabel() {
        altitudeLabel.font = .systemFont(ofSize: 25, weight: .bold)
        altitudeLabel.textColor = .white
        altitudeLabel.text = "ABC"
        altitudeLabel.textAlignment = .center
        
        addSubview(altitudeLabel)
        
        altitudeLabel.translatesAutoresizingMaskIntoConstraints = false
        altitudeLabel.topAnchor.constraint(equalTo: altitudeView.topAnchor, constant: 10).isActive = true
        altitudeLabel.leadingAnchor.constraint(equalTo: altitudeView.leadingAnchor, constant: 10).isActive = true
        altitudeView.trailingAnchor.constraint(equalTo: altitudeLabel.trailingAnchor, constant: 10).isActive = true
    }
    
    /*
     *  Prepare Altitude Unit Label
     */
    
    func prepareAltitudeUnitLabel() {
        altitudeUnitLabel.text = "ft"
        altitudeUnitLabel.font = .systemFont(ofSize: 12, weight: .bold)
        altitudeUnitLabel.textColor = .white
        altitudeUnitLabel.textAlignment = .center
        
        altitudeView.addSubview(altitudeUnitLabel)
        
        altitudeUnitLabel.translatesAutoresizingMaskIntoConstraints = false
        altitudeUnitLabel.leadingAnchor.constraint(equalTo: altitudeView.leadingAnchor).isActive = true
        altitudeUnitLabel.trailingAnchor.constraint(equalTo: altitudeView.trailingAnchor).isActive = true
        altitudeUnitLabel.topAnchor.constraint(equalTo: altitudeLabel.bottomAnchor, constant: 3).isActive = true
    }
    
    /*
     *  Prepare Altitude Approximate Label
     */
    
    func prepareAltitudeApproximateLabel() {
        
        altitudeApproximateLabel.text = "≈ 23 ft"
        altitudeApproximateLabel.font = .systemFont(ofSize: 12, weight: .bold)
        altitudeApproximateLabel.textColor = .white
        altitudeApproximateLabel.textAlignment = .center
        
        altitudeView.addSubview(altitudeApproximateLabel)
        
        altitudeApproximateLabel.translatesAutoresizingMaskIntoConstraints = false
        altitudeApproximateLabel.topAnchor.constraint(equalTo: altitudeUnitLabel.bottomAnchor, constant: 5).isActive = true
        altitudeApproximateLabel.leadingAnchor.constraint(equalTo: altitudeView.leadingAnchor).isActive = true
        altitudeApproximateLabel.trailingAnchor.constraint(equalTo: altitudeView.trailingAnchor).isActive = true
        
    }
    
    /*
     *  Prepare Barometer Title View
     */
    
    func prepareBarometerTitle() {
                
        barometerTitleView.backgroundColor = .black.withAlphaComponent(0.8)
        barometerTitleView.layer.cornerRadius = 10
        
        self.addSubview(barometerTitleView)
        
        barometerTitleView.translatesAutoresizingMaskIntoConstraints = false
        barometerTitleView.leadingAnchor.constraint(equalTo: altitudeView.trailingAnchor, constant: 7).isActive = true
        barometerTitleView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        barometerTitleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 7).isActive = true
        barometerTitleView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        barometerTitleLabel.text = "Barometre"
        barometerTitleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        barometerTitleLabel.textColor = .white
        barometerTitleLabel.textAlignment = .left
        
        barometerTitleView.addSubview(barometerTitleLabel)
        
        barometerTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        barometerTitleLabel.centerXAnchor.constraint(equalTo: barometerTitleView.centerXAnchor).isActive = true
        barometerTitleLabel.centerYAnchor.constraint(equalTo: barometerTitleView.centerYAnchor).isActive = true
        
    }
    
    /*
     *  Prepare Barometer Label
     */
    
    func prepareBarometerLabel() {
        
        barometerContentView.layer.cornerRadius = 10
        barometerContentView.backgroundColor = .black.withAlphaComponent(0.7)
        
        self.addSubview(barometerContentView)
        
        barometerContentView.translatesAutoresizingMaskIntoConstraints = false
        barometerContentView.leadingAnchor.constraint(equalTo: barometerTitleView.leadingAnchor).isActive = true
        barometerContentView.trailingAnchor.constraint(equalTo: barometerTitleView.trailingAnchor).isActive = true
        barometerContentView.topAnchor.constraint(equalTo: barometerTitleView.bottomAnchor,constant: 7).isActive = true
        barometerContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7).isActive = true
        
        barometerLabel.font = .systemFont(ofSize: 12, weight: .bold)
        barometerLabel.textColor = .white
        barometerLabel.text = "ABC"
        barometerLabel.textAlignment = .left
                
        barometerContentView.addSubview(barometerLabel)
        
        barometerLabel.translatesAutoresizingMaskIntoConstraints = false
        barometerLabel.centerXAnchor.constraint(equalTo: barometerContentView.centerXAnchor).isActive = true
        barometerLabel.centerYAnchor.constraint(equalTo: barometerContentView.centerYAnchor).isActive = true
        
    }
    
    /*
     *  Prepare Coordinate Label
     */
    
    func prepareCoordinateLabel() {
        
        coordinateContentView.layer.cornerRadius = 10
        coordinateContentView.backgroundColor = .black.withAlphaComponent(0.7)
        
        coordinateContentView.isUserInteractionEnabled = true
        coordinateContentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedCoordinate)))
        
        self.addSubview(coordinateContentView)
        
        coordinateContentView.translatesAutoresizingMaskIntoConstraints = false
        coordinateContentView.leadingAnchor.constraint(equalTo: coordinateTitleView.leadingAnchor).isActive = true
        coordinateContentView.trailingAnchor.constraint(equalTo: coordinateTitleView.trailingAnchor).isActive = true
        coordinateContentView.topAnchor.constraint(equalTo: coordinateTitleView.bottomAnchor, constant: 7).isActive = true
        coordinateContentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7).isActive = true
        
        coordinateLabel.font = .systemFont(ofSize: 12, weight: .bold)
        coordinateLabel.textColor = .white
        coordinateLabel.text = "41.7425\n39.9134"
        coordinateLabel.textAlignment = .left
        coordinateLabel.numberOfLines = 0
        
        coordinateContentView.addSubview(coordinateLabel)
        
        coordinateLabel.translatesAutoresizingMaskIntoConstraints = false
        coordinateLabel.centerXAnchor.constraint(equalTo: coordinateContentView.centerXAnchor).isActive = true
        coordinateLabel.centerYAnchor.constraint(equalTo: coordinateContentView.centerYAnchor).isActive = true
        
    }
    
    /*
     *  Prepare Coordinate Title Label
     */
    
    func prepareCoordinateTitleLabel() {
        
        coordinateTitleView.backgroundColor = .black.withAlphaComponent(0.8)
        coordinateTitleView.layer.cornerRadius = 10
        
        self.addSubview(coordinateTitleView)
        
        coordinateTitleView.translatesAutoresizingMaskIntoConstraints = false
        coordinateTitleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -7).isActive = true
        coordinateTitleView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        coordinateTitleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 7).isActive = true
        coordinateTitleView.leadingAnchor.constraint(equalTo: barometerTitleView.trailingAnchor, constant: 7).isActive = true
        
        coordinateTitleLabel.text = "Koordinatlar"
        coordinateTitleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        coordinateTitleLabel.textColor = .white
        coordinateTitleLabel.textAlignment = .left
        
        coordinateTitleView.addSubview(coordinateTitleLabel)
        
        coordinateTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        coordinateTitleLabel.centerXAnchor.constraint(equalTo: coordinateTitleView.centerXAnchor).isActive = true
        coordinateTitleLabel.centerYAnchor.constraint(equalTo: coordinateTitleView.centerYAnchor).isActive = true
        
    }
    
    /*
     *  Bind
     */
    
    func bind(altitude: String, altitudeUnit: String, accuary: String, unitsAbbrev: String ,barometer: Float, location: CLLocation) {
        
        self.altitudeLabel.text = altitude
        self.altitudeUnitLabel.text = altitudeUnit
        self.altitudeApproximateLabel.text = "≈ \(accuary) \(unitsAbbrev)"
        self.barometerLabel.text = String(format: "%.2f", barometer) + " atm"
        self.coordinateLabel.text = "\(location.coordinate.latitude)\n\(location.coordinate.longitude)"


    }
    
    /*
     *  Tapped Altitude
     */
    
    @objc func tappedAltitude() {
        self.altitudeTappedHandler?()
    }
    
    @objc func tappedCoordinate() {
        
        self.coordinateTappedHandler?()
        
    }
    
    /*
     *  Required Init
     */
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
