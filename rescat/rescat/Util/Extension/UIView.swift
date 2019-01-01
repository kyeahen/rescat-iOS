//
//  UIView.swift
//  rescat
//
//  Created by jigeonho on 30/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
extension UIView {
    func drawPercentage( _ value : Double , _ overallColor : UIColor, _ dataColor : UIColor ) {
        
        backgroundColor = overallColor
        let x = CGFloat(Float(frame.width) * Float(value))
        let v = UIView(frame: CGRect(x: x, y: 0, width: frame.width - x, height: frame.height))
        v.backgroundColor = dataColor
        addSubview(v)

    }
    func roundCorner( _ value : Double ){
      
        layer.cornerRadius = CGFloat(value)
        layer.masksToBounds = true
        
    }
    func drawShadow( _ value : Double) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = CGFloat(value)
    }
    
    
}
extension UIImageView {
    
//    func drawShadow( _ value : Double) {
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.3
//        layer.shadowOffset = CGSize(width: -1, height: 1)
//        layer.shadowRadius = CGFloat(value)
//    }
}
