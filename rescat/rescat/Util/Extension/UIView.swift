//
//  UIView.swift
//  rescat
//
//  Created by jigeonho on 30/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    func drawPercentage( _ value : Double ) {
        
//        
//        let v = UIView(frame: CGRect(x: self.frame.width * value, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height))
//        
        
    }
    func roundCorner( _ value : Double ){
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 4.0

        layer.cornerRadius = CGFloat(value)
        layer.masksToBounds = true
        
    }
    func dropShadow(offsetX: CGFloat, offsetY: CGFloat, color: UIColor, opacity: Float, radius: CGFloat, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: offsetX, height: offsetY)
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
}
