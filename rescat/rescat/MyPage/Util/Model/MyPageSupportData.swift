//
//  MyPageSupportData.swift
//  rescat
//
//  Created by 김예은 on 07/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation

struct MyPageSupportData: Codable {
    let category: Int
    let currentAmount: Int
    let goalAmount: Int
    let idx: Int
    let introduction: String
    let limitAt: String?
    let mainPhoto: MySupportPhotoData
    let title: String
    let name: String?
    let phone: String?
}

struct MySupportPhotoData: Codable {
    let createdAt: String
    let url: String
}
