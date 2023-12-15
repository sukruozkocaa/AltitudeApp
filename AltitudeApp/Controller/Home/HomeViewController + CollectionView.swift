//
//  HomeViewController + CollectionView.swift
//  AltitudeApp
//
//  Created by Şükrü on 10.09.2023.
//

import Foundation
import UIKit

extension HomeViewController {
    
    /*
     *  Prepare CollectionView
     */
    
    func prepareCollectionView() {
        
        view.addSubview(collectionView)

        collectionView.register(AltimeterCoordinateCollectionViewCell.self, forCellWithReuseIdentifier: "AltimeterCoordinateCell")
        collectionView.register(AltimeterLocationCollectionViewCell.self, forCellWithReuseIdentifier: "AltimeterLocationCell")
        
        collectionView.reloadData()
        collectionView.carouselDataSource = self
        collectionView.isAutoscrollEnabled = true
        collectionView.autoscrollTimeInterval = 6.0
        collectionView.layer.cornerRadius = 2
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.flowLayout.itemSize = CGSize(width: self.view.frame.width, height: 100)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        
    }
    
}
extension HomeViewController: CarouselCollectionViewDataSource {
    var numberOfItems: Int {
        return 2
    }
    
    func carouselCollectionView(_ carouselCollectionView: CarouselCollectionView, cellForItemAt index: Int, fakeIndexPath: IndexPath) -> UICollectionViewCell {
        
        if index == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AltimeterCoordinateCell", for: fakeIndexPath) as! AltimeterCoordinateCollectionViewCell
            
            cell.bind(altitude: altitudeText, altitudeUnit: unitsAbbrevText, accuary: accuracyText, unitsAbbrev: unitsAbbrevText, barometer: pressure_atm, location: self.location)
                        
            cell.altitudeTappedHandler = {
                
                self.changeUnits()
                
            }
            
            cell.coordinateTappedHandler = {
                
                UIApplication.shared.openURL(URL(string:"https://www.google.com/maps/search/?api=1&query=\(self.location.coordinate.latitude),\(self.location.coordinate.longitude)")!)
                
            }
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AltimeterLocationCell", for: fakeIndexPath) as! AltimeterLocationCollectionViewCell
            
            cell.locationLabel.text = self.addressText
                        
            return cell
        }
    }
}

