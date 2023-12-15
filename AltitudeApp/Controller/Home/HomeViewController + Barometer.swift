//
//  HomeViewController + Barometer.swift
//  AltitudeApp
//
//  Created by Şükrü on 10.09.2023.
//

import Foundation
import CoreMotion

extension HomeViewController {
    
    func prepareBarometer() {
        
        if CMAltimeter.isRelativeAltitudeAvailable() {
            // Start Altimeter sensor data readout.
            self.altimeterManager.startRelativeAltitudeUpdates(to: OperationQueue.main) { (data, error) in
                if let altimeterData = data {
                    self.relativeAltitude = altimeterData.relativeAltitude.floatValue
                    self.pressure_atm = 0.00986923266 * altimeterData.pressure.floatValue
                    self.barometerText = "\(self.pressure_atm) atm"
                    self.collectionView.reloadData()
                }
            }
        } else {
            self.barometerText = "-"
        }
        
    }
    
    
}
