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
