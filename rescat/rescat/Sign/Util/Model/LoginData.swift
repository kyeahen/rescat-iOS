//
//  LoginData.swift
//  rescat
//
//  Created by 김예은 on 10/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation

struct LoginData: Codable {
    let mileage: Int
    let idx: Int
    let jwtTokenDto: TokenData
    let role: String
    let regions: [String]
    let emdCodes: [Int]
}
