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
    let idx: Int //알림 리스트 인덱스
    let notification: NotiData
    let isChecked: Int //알림 확인 여부(0:안읽음, 1:읽음)
}

struct NotiData: Codable {
    let createdAt: String
    let idx: Int //해당 알림에 대한 인덱스 - 신청서일 때 보냄
    let contents: String
    let targetType: String? //펀딩, 입양신청서...
    let targetIdx: Int? //해당 글번호에 대한 인덱스(펀딩, 입양 글)
    let targetIdxNull: Bool
}
