//
//  AddAreaService.swift
//  rescat
//
//  Created by 김예은 on 10/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation

struct AddAreaService: PostableService, APIServie {
    
    typealias NetworkData = DefaultData
    static let shareInstance = AddAreaService()
    
    //MARK: POST - /api/users/mypage/region (지역 추가)
    func postAddArea(address: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let addURL = self.url("users/mypage/region?regionFullName=\(address)")
        
        post(addURL, params: [:]) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.postSuccess.rawValue : //201
                    completion(.networkSuccess(networkResult.resResult))
                    
                case HttpResponseCode.accessDenied.rawValue : //401
                    completion(.accessDenied)
                    
                case HttpResponseCode.conflict.rawValue : //409
                    completion(.duplicated)
                    
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
                    
                case HttpResponseCode.conflict.rawValue.description : //409
                    completion(.duplicated)
                    
                case HttpResponseCode.serverErr.rawValue.description : //500
                    completion(.serverErr)
                    
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
