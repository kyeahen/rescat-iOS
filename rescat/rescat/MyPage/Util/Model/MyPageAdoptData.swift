//
//  MyPageAdoptData.swift
//  rescat
//
//  Created by 김예은 on 07/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation

struct MyPageAdoptData: Codable {
    
    let contents: String
    let createdAt: String
    let idx: Int
    let isFinished: Bool
    let name: String
    let photo: MyPhotoData
    let type: Int
    let updatedAt: String
    let viewCount: Int

}

struct MyPhotoData: Codable {
    let createdAt: String
    let url: String
}
