//
//  CarePostMainModel.swift
//  rescat
//
//  Created by jigeonho on 10/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation
class CarePostMainModel : Codable {
    var idx : Int?
    var name : String?
    var contents : String?
    var photo : CarePostMainPhotoModel?
    var type : Int?
    var viewCount : Int?
    var createdAt : String?
    var updatedAt : String?
    var isFinished : Bool?
}
class CarePostMainPhotoModel : Codable{
    var createdAt : String?
    var url : String?
}
