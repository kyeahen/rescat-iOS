//
//  AdoptData.swift
//  rescat
//
//  Created by 김예은 on 02/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation

struct AdoptData: Codable {
    let idx: Int
    let name: String
    let contents: String
    let photo: AdoptPhotoData
    let type: Int?
    let viewCount: Int
    let createdAt: String
    let isFinished: Bool
}

struct AdoptPhotoData: Codable {
    let createdAt: String
    let url: String
}
