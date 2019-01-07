//
//  PostBoxDetailData.swift
//  rescat
//
//  Created by 김예은 on 08/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation

struct PostBoxDetailData: Codable {
    let createdAt: String
    let idx: Int
    let title: String
    let contents: String
    let introduction: String
    let goalAmount: Int
    let currentAmount: Int
    let bankName: String
    let account: String
    let mainRegion: String
    let certifications: [PostCertiData]
    let category: Int
    let photos: [PostPhotoData]
    let limitAt: String
    let isConfirmed: Int
    let nickname: String
    let isWriter: Bool
}

struct PostCertiData: Codable {
    let createdAt: String
    let url: String
    let isCertification: Bool
}

struct PostPhotoData: Codable {
    let createdAt: String
    let url: String
    let isCertification: Bool
}
