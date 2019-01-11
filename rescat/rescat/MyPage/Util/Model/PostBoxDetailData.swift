//
//  PostBoxDetailData.swift
//  rescat
//
//  Created by 김예은 on 08/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation

struct PostBoxDetailData: Codable {
    let targetIdx: Int //글번호
    let targetType: String
    let careApplication: CareApplication
}

struct CareApplication: Codable {
    let createdAt: String
    let idx: Int
    let type: Int
    let name: String
    let phone: String
    let birth: String?
    let job: String
    let address: String
    let houseType: String
    let companionExperience: Bool
    let finalWord: String
    let isAccepted: Bool
    let title: String?
}


