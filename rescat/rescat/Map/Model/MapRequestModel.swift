//
//  MapRequestModel.swift
//  rescat
//
//  Created by jigeonho on 05/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation
struct MapRequestModel : Codable {
    
    var editCategory : Bool?
    var photoUrl : String?
    var regionFullName : String?
    var requestType : Int?
    var registerType : Int?
    var name : String?
    var etc : String?
    var lat : Double?
    var lng : Double?
    var phone : String?
    var address : String?
    var radius : Int?
    var sex : Int?
    var age : String?
    var tnr : Int?
    var markerIdx : Int?
//    func getProperty() -> [String:Any] {
//        var param = [String:Any]()
//        if editCategory == nil {
//            param["photoUrl"] =
//        }
//    }
}
