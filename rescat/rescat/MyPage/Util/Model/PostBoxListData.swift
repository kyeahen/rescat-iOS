//
//  PostBoxListData.swift
//  rescat
//
//  Created by 김예은 on 08/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation

struct PostBoxListData: Codable {
    let createdAt: String
    let idx: Int
    let notification: NotiData
    let isChecked: Int
}

struct NotiData: Codable {
    let createdAt: String
    let idx: Int
    let contents: String
    let targetType: String?
    let targetIdx: Int?
    let targetIdxNull: Bool
}
