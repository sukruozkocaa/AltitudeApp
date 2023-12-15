//
//  Extensions.swift
//  AltitudeApp
//
//  Created by Şükrü on 6.09.2023.
//

import Foundation
import UIKit

let screenH: CGFloat = UIScreen.main.bounds.height

let screenW: CGFloat = UIScreen.main.bounds.width

extension UIColor {
    
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
}

extension UIViewController {
    
    func sheetPresentationController(viewController: UIViewController, height: CGFloat, isDefaultMedium: Bool) {
        
        let vc = viewController

        if #available(iOS 15.0, *) {
                
            if let sheet = vc.sheetPresentationController {
                    
                var detents: [UISheetPresentationController.Detent] = []
                    
                // ---------------------------------------------
                    
                if #available(iOS 16.0, *) {
                        
                    detents.append(UISheetPresentationController.Detent.custom { _ in return height })
                    detents.append(UISheetPresentationController.Detent.medium())
                        
                } else {
                    
                    if isDefaultMedium == true {
                        
                        detents.append(UISheetPresentationController.Detent.medium())
                        
                    } else {
                        
                        detents.append(UISheetPresentationController.Detent.large())
                        
                    }
                }
                
                sheet.detents = detents
                sheet.preferredCornerRadius = 20
                
            }
                    
        }
                
        self.present(vc, animated: true)
        
    }
}

extension String {
    
    func DegreeToString(d: Double) -> String {
        let degree = Int(d)
        let tempMinute = Float(d - Double(degree)) * 60
        let minutes = Int(tempMinute)
        let second = Int((tempMinute - Float(minutes)) * 60)
        
        return "\(degree)°\(minutes)′\(second)″"
    }
}
