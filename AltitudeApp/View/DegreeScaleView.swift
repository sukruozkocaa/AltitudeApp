//
//  DegreeScaleView.swift
//  AltitudeApp
//
//  Created by Şükrü on 8.09.2023.
//

import Foundation
import UIKit

class DegreeScaleView: UIView {
    
    private lazy var backgroundView: UIView = {
        let v = UIView(frame: bounds)
        return v
    }()
    
    private lazy var levelView: UIView = {
        let levelView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width / 2 - 50, height: 1))
        levelView.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        levelView.backgroundColor = .white
        return levelView
    }()
    
    private lazy var verticalView: UIView = {
        let verticalView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: self.frame.size.height / 2 - 50))
        verticalView.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        verticalView.backgroundColor = .white
        return verticalView
    }()
    
    private lazy var lineView: UIView = {
        let lineView = UIView(frame: CGRect(x: self.frame.size.width / 2 - 1.5, y: 20, width: 3, height: 60))
        lineView.backgroundColor = .white
        return lineView
    }()
    
    private lazy var compassTriangleView: UIView = {
        let triangle = UIView(frame: CGRect(x: 0, y: 0, width: screenW, height: screenW))
        triangle.backgroundColor = .clear
        return triangle
    }()
    
    private lazy var redTriangleView = UIView()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        layer.cornerRadius = frame.size.width / 2
        addSubview(backgroundView)
        addSubview(levelView)
        addSubview(verticalView)
        insertSubview(lineView, at: 0)
        configScaleDial()
        addSubview(compassTriangleView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DegreeScaleView {

    private func calculateTextPositon(withArcCenter center: CGPoint, andAngle angle: CGFloat, andScale scale: CGFloat) -> CGPoint {
        let x = (self.frame.size.width / 2 - 50) * scale * CGFloat(cosf(Float(angle)))
        let y = (self.frame.size.width / 2 - 50) * scale * CGFloat(sinf(Float(angle)))
        return CGPoint(x: center.x + x, y: center.y + y)
    }
    
    public func resetDirection(_ heading: CGFloat) {
        backgroundView.transform = CGAffineTransform(rotationAngle: heading)
        for label in backgroundView.subviews {
            backgroundView.subviews[1].transform = .identity
            label.transform = CGAffineTransform(rotationAngle: -heading)
        }
    }
    
}

//MARK: - Configure
extension DegreeScaleView {
    
    private func configScaleDial() {
        
        let degree_360: CGFloat = CGFloat.pi
        
        let degree_180: CGFloat = degree_360 / 2
        
        let angle: CGFloat = degree_360 / 90
        
        let directionArray = ["K", "D", "G", "B"]
        
        let po = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        
        for i in 0 ..< 180 {
            
            let startAngle: CGFloat = -(degree_180 + degree_360 / 180 / 2) + angle * CGFloat(i)
            
            let endAngle: CGFloat = startAngle + angle / 2
            
            let bezPath = UIBezierPath(arcCenter: po, radius: frame.size.width / 2 - 70, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            
            let shapeLayer = CAShapeLayer()
            
            if i % 15 == 0 {
                shapeLayer.strokeColor = UIColor.white.cgColor
                shapeLayer.lineWidth = 20
            }else {
                shapeLayer.strokeColor = UIColor.gray.cgColor
                shapeLayer.lineWidth = 20
            }
            shapeLayer.path = bezPath.cgPath
            shapeLayer.fillColor = UIColor.clear.cgColor
            backgroundView.layer.addSublayer(shapeLayer)
            
            if i % 15 == 0 {

                var tickText = "\(i * 2)"
                
                let textAngle: CGFloat = startAngle + (endAngle - startAngle) / 2
                
                let point: CGPoint = calculateTextPositon(withArcCenter: po, andAngle: textAngle, andScale: 1.15)
                
                // UILabel
                let label = UILabel(frame: CGRect(x: point.x, y: point.y, width: 30, height: 20))
                label.center = point
                label.text = tickText
                label.textColor = .white
                label.font = UIFont.systemFont(ofSize: 15)
                label.textAlignment = .center
                backgroundView.addSubview(label)
                
                if i % 45 == 0 {
                    tickText = directionArray[i / 45]
                    
                    let point2: CGPoint = calculateTextPositon(withArcCenter: po, andAngle: textAngle, andScale: 0.65)
                    // UILabel
                    let label2 = UILabel(frame: CGRect(x: point2.x, y: point2.y, width: 30, height: 30))
                    label2.center = point2
                    label2.text = tickText
                    label2.textColor = .white
                    label2.font = UIFont.systemFont(ofSize: 27)
                    label2.textAlignment = .center
                    
                    if tickText == "K" {
                        DrawRedTriangleView(point)
                    }
                    
                    backgroundView.addSubview(label2)
                }
            }
        }
    }
    
    private func DrawRedTriangleView(_ point: CGPoint) {
        redTriangleView = UIView(frame: CGRect(x: point.x, y: point.y, width: 12, height: 12))
        redTriangleView.center = CGPoint(x: point.x, y: point.y + 17)
        redTriangleView.backgroundColor = .clear
        backgroundView.addSubview(redTriangleView)
        
        let trianglePath = UIBezierPath()
        var point = CGPoint(x: 0, y: 12)
        trianglePath.move(to: point)
        point = CGPoint(x: 12 / 2, y: 0)
        trianglePath.addLine(to: point)
        point = CGPoint(x: 12, y: 12)
        trianglePath.addLine(to: point)
        trianglePath.close()
        let triangleLayer = CAShapeLayer()
        triangleLayer.path = trianglePath.cgPath
        triangleLayer.fillColor = UIColor.red.cgColor
        redTriangleView.layer.addSublayer(triangleLayer)
    }
}
