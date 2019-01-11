//
//  ModifyMyPageAreaService.swift
//  rescat
//
//  Created by 김예은 on 10/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ModifyMyPageAreaService: PuttableArrayService, APIServie {
    
    typealias NetworkData = DefaultData
    static let shareInstance = ModifyMyPageAreaService()
    
    //MARK: PUT - api/users/mypage/region (케어테이커 지역 수정)
    func putMyPageArea(params: [String : Any], completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let modURL = self.url("users/mypage/region")
        
        putArray(modURL, params: params) { (result) in
            
            print(JSON(params))
            switch result {
            
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.getSuccess.rawValue : //200
                    completion(.networkSuccess(networkResult.resResult))
                    
                case HttpResponseCode.badRequest.rawValue : //400
                    completion(.badRequest)
                    
                case HttpResponseCode.accessDenied.rawValue : //401
                    completion(.accessDenied)
                    
                case HttpResponseCode.serverErr.rawValue : //500
                    completion(.serverErr)
                    
                default :
                    print("Success: \(networkResult.resCode)")
                    break
                }
                break
                
            case .error(let resCode):
                switch resCode {
                    
                case HttpResponseCode.badRequest.rawValue.description : //400
                    completion(.badRequest)
                    
                case HttpResponseCode.accessDenied.rawValue.description : //401
                    completion(.accessDenied)
                    
                default :
                    print("Error: \(resCode)")
                    break
                }
                break
                
            case .failure(_):
                completion(.networkFail)
                print("Fail: Network Fail")
            }
        }
        
    }
}
