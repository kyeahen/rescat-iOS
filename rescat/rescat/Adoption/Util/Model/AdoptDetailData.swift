//
//  AdoptDetailData.swift
//  rescat
//
//  Created by 김예은 on 02/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation

struct AdoptDetailData: Codable {
    let age: String
    let breed: String
    let contents: String
    let endProtectionPeriod: String?
    let etc: String?
    let idx: Int
    let isConfirmed: Int
    let name: String
    let nickname: String
    let photos: [AdoptPhotoData]
    let sex: Int
    let startProtectionPeriod: String?
    let tnr: Int
    let type: Int
    let vaccination: String?
    let viewCount: Int
}
