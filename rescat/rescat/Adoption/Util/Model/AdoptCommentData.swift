//
//  AdoptCommentData.swift
//  rescat
//
//  Created by 김예은 on 02/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation

struct AdoptCommentData: Codable {
    let createdAt: String?
    let idx: Int
    let contents: String
    let photoUrl: String?
    let nickname: String
    let userRole: String
    let isWriter: Bool?
    let warning: Int
}
