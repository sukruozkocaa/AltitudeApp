//
//  GPSSignalView.swift
//  AltitudeApp
//
//  Created by Şükrü on 6.09.2023.
//

import Foundation
import UIKit

class GPSSignalView: UIView {
    
    let titleLabel = UILabel()
    
    let line1 = UIView()
    
    let line2 = UIView()
    
    let line3 = UIView()
    
    let line4 = UIView()
    
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
        
        self.layer.cornerRadius = 4
        
        self.prepareTitleLabel()
        
        self.prepareLine4()

        self.prepareLine3()
        
        self.prepareLine2()
        
        self.prepareLine1()
        
    }
    
    /*
     *  Prepare Title Label
     */
    
    func prepareTitleLabel() {
        
        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        titleLabel.text = "GPS"
        titleLabel.textColor = .white
        
        self.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 7).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
    
    /*
     *  Prepare Line 1
     */
    
    func prepareLine1() {
        
        line1.layer.cornerRadius = 2
        line1.backgroundColor = .red
        
        self.addSubview(line1)
        
        line1.translatesAutoresizingMaskIntoConstraints = false
        line1.heightAnchor.constraint(equalToConstant: 7).isActive = true
        line1.widthAnchor.constraint(equalToConstant: 3).isActive = true
        line1.bottomAnchor.constraint(equalTo: line2.bottomAnchor, constant: 0).isActive = true
        line1.trailingAnchor.constraint(equalTo: line2.leadingAnchor, constant: -1.5).isActive = true
        
    }
    
    /*
     *  Prepare Line 2
     */
    
    func prepareLine2() {
        
        line2.backgroundColor = .red
        line2.layer.cornerRadius = 2

        self.addSubview(line2)
        
        line2.translatesAutoresizingMaskIntoConstraints = false
        line2.widthAnchor.constraint(equalToConstant: 3).isActive = true
        line2.heightAnchor.constraint(equalToConstant: 9).isActive = true
        line2.bottomAnchor.constraint(equalTo: line3.bottomAnchor, constant: 0).isActive = true
        line2.trailingAnchor.constraint(equalTo: line3.leadingAnchor, constant: -1.5).isActive = true
    }
    
    /*
     *  Prepare Line 3
     */
    
    func prepareLine3() {
        
        line3.backgroundColor = .red
        line3.layer.cornerRadius = 2

        self.addSubview(line3)
        
        line3.translatesAutoresizingMaskIntoConstraints = false
        line3.widthAnchor.constraint(equalToConstant: 3).isActive = true
        line3.heightAnchor.constraint(equalToConstant: 11).isActive = true
        line3.bottomAnchor.constraint(equalTo: line4.bottomAnchor, constant: 0).isActive = true
        line3.trailingAnchor.constraint(equalTo: line4.leadingAnchor, constant: -1.5).isActive = true
    }
    
    /*
     *  Prepare Line 4
     */
    
    func prepareLine4() {
        
        line4.backgroundColor = .red
        line4.layer.cornerRadius = 2

        self.addSubview(line4)
        
        line4.translatesAutoresizingMaskIntoConstraints = false
        line4.widthAnchor.constraint(equalToConstant: 3).isActive = true
        line4.heightAnchor.constraint(equalToConstant: 13).isActive = true
        line4.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        line4.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -7).isActive = true
        
    }
    
    /*
     *  Configure GPS Signal
     */
    
    func configureGPS(horizontalAccuracy: CGFloat) {
                
        if (horizontalAccuracy < 0) {
          
            self.line1.backgroundColor = .red
            self.line2.backgroundColor = .white
            self.line3.backgroundColor = .white
            self.line4.backgroundColor = .white
            
        } else if (horizontalAccuracy > 163) {
            
            self.line1.backgroundColor = .orange
            self.line2.backgroundColor = .orange
            self.line3.backgroundColor = .white
            self.line4.backgroundColor = .white
          
        } else if (horizontalAccuracy > 48) {
            
            self.line1.backgroundColor = .orange
            self.line2.backgroundColor = .orange
            self.line3.backgroundColor = .orange
            self.line4.backgroundColor = .white
            
        } else {
          
            self.line1.backgroundColor = .green
            self.line2.backgroundColor = .green
            self.line3.backgroundColor = .green
            self.line4.backgroundColor = .green
            
        }
    }
    
    /*
     *  Required Init
     */
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
