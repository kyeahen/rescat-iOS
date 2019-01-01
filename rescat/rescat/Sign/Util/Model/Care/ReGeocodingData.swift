//
//  ReGeocodingData.swift
//  rescat
//
//  Created by 김예은 on 31/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation

struct ReGeocodingData: Codable {
    let status: StatusData
    let results: [ResultData]
}

struct StatusData: Codable {
    let code: Int
    let name: String
    let message: String
}

struct ResultData: Codable {
    let name: String
    let code: CodeData
    let region: RegionData
//    let Land: LandData
}

struct CodeData: Codable {
    let id: String
    let type: String
    let mappingId: String
}

struct RegionData: Codable {
    let area0: AreaData
    let area1: AreaData //서울시
    let area2: AreaData //동대문구
    let area3: AreaData //휘경동
    let area4: AreaData
}

//struct LandData: Codable {
//    let type : String
//    let addition4 : AdditionData
//    let coords : CoordData
//    let addition3 : AdditionData
//    let addition2 : AdditionData
//    let addition1 : AdditionData
//    let number2 : String
//    let number1 : String
//    let addition0 : AdditionData
//}
//
//struct AdditionData: Codable {
//    let type : String
//    let value : String
//}

struct AreaData: Codable {
    let name: String
    let coords: CoordData
}

struct CoordData: Codable {
    let center: CenterData
}

struct CenterData: Codable {
    let crs: String
    let x: Double
    let y: Double
}
