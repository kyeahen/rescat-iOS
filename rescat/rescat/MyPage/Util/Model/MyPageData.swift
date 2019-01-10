//
//  MyPageData.swift
//  rescat
//
//  Created by 김예은 on 06/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation

struct MyPageData: Codable {
    let id: String
    let mileage: Int?
    let nickname: String
    let phone: String?
    let regions: [MyPageRegions]?
    let role: String? //MEMBER, CARETAKER, GUEST
    let name: String?
    let isFinished: Bool?
}

struct MyPageRegions: Codable {
    let code: Int
    let name: String
}
