//
//  MarkerModel.swift
//  rescat
//
//  Created by jigeonho on 05/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation
struct MarkerModel : Codable {
    var address : String?
    var age : String?
    var category : Int?
    var etc : String?
    var idx : Int?
    var lat : Double?
    var lng : Double?
    var name : String?
    var phone : String?
    var photoUrl : String?
    var radius : Int?
    var sex : Int?
    var tnr : Int?
    var region : RegionModel?
    
}
struct RegionModel : Codable {
    var code : Int?
    var name : String?
}
