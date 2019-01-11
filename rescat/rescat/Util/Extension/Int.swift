//
//  Int.swift
//  rescat
//
//  Created by jigeonho on 31/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation
extension Int{
    func getMoney() -> String{
        
        return Formatter.withSeparator.string(for: self) ?? ""

    }
}
extension Formatter{
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}
extension Double {
    public static func random(lower: Double = 0, _ upper: Double = 100) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }

}
