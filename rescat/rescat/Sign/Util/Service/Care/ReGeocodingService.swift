//
//  ReGeocodingService.swift
//  rescat
//
//  Created by 김예은 on 31/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct ReGeocodingService {

    typealias networkResult = (resCode: Int, resResult: Codable)
    
    static func getAddress(lat: Double, lon: Double, completion: @escaping (Result<networkResult>)-> Void) {
     
        let mapURL = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=\(lon),\(lat)&sourcecrs=epsg:4326&output=json&orders=addr,admcode"
        
        let header: HTTPHeaders = [ "Content-Type" : "application/json",
                             "X-NCP-APIGW-API-KEY-ID" : "bedux5fmyf",
                             "X-NCP-APIGW-API-KEY" : "EFYzlcjoUiUrlScgQEc3SiqCrIa2uvcPkxoltOaL"]

        Alamofire.request(mapURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseData() {
            (res) in
            
            switch res.result {
                
            case .success:
                
                if let value = res.result.value {
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let status = res.response?.statusCode
                        let addressData = try decoder.decode(ReGeocodingData.self, from: value)
                        let nullData = DefaultData()
                        
                        print(JSON(value))
                        
                        if status == 200 {
                            
                            let code = addressData.status.code
                            if code == 0 {
                                
                                let result : networkResult = (0, addressData)
                                completion(.success(result))
            
                                print("성공데스")
                            } else {
                                let result : networkResult = (3, nullData)
                                completion(.success(result))
                            }
                        } else if status == 400 {
                            let result : networkResult = (3, nullData)
                            completion(.success(result))
                        } else {

                            let result : networkResult = (3, nullData)
                            completion(.success(result))
                        }
                        
                    } catch {
                        print("변수 문제")
                        
                    }
                    
                }
                break
                
            case .failure(let err):
                print(err.localizedDescription)
                break
            }
        }
        
    }
}

