//
//  FundingRequestModel.swift
//  rescat
//
//  Created by jigeonho on 05/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation
struct FundingRequestModel : Codable {
  
    var account : String?
    var bankName : String?
    var category : Int?
    var certificationUrls : [String]?
    var contents : String?
    var goalAmount : Int?
    var introduction : String?
    var limitAt : String?
    var mainRegion : String?
    var photoUrls : [String]?
    var title : String?
        
    
}
