//
//  ReGeocodingService.swift
//  rescat
//
//  Created by 김예은 on 31/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation

struct ReGeocodingService: GettableService {
    
    //MARK: 전체 코스 종류 및 정보 보기 - /api/course
    typealias NetworkData = ReGeocodingData
    static let shareInstance = ReGeocodingService()
    
    func getAddressData(lat: String, lon: String, completion : @escaping (NetworkResult<Any>) -> Void) {
        
        let addressURL = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=\(lat),\(lon)&sourcecrs=epsg:4326&output=json&orders=addr,admcode"
        
        get(addressURL) { (result) in
            
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode{
                    
                case HttpResponseCode.getSuccess.rawValue : //200
                    completion(.networkSuccess(networkResult.resResult))
                    
                case HttpResponseCode.serverErr.rawValue : //500
                    completion(.serverErr)
                    
                default :
                    print("Success: \(networkResult.resCode)")
                    break
                }
                break
                
            case .error(let errMessage) :
                
                print(errMessage)
                break
                
            case .failure(_) :
                completion(.networkFail)
                print("Fail: Network Fail")
            }
        }
    }
}

