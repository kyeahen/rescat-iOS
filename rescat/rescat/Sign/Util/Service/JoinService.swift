//
//  JoinService.swift
//  rescat
//
//  Created by 김예은 on 30/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation

struct JoinService: PostableService, APIServie {
    
    typealias NetworkData = DefaultData
    static let shareInstance = JoinService()
    
    func postJoin(params: [String : Any], completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let loginURL = self.url("users")
        
        post(loginURL, params: params) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode {
                case HttpResponseCode.postSuccess.rawValue : //201
                    
                    completion(.networkSuccess(networkResult.resResult))
                    
                case HttpResponseCode.badRequest.rawValue : //400
                    completion(.badRequest)
                    
                case HttpResponseCode.conflict.rawValue : //409
                    completion(.duplicated)
                    
                case HttpResponseCode.serverErr.rawValue : //500
                    completion(.serverErr)
                    
                default :
                    print("no 201/500 rescode is \(networkResult.resCode)")
                    break
                }
                
                break
                
            case .error(let resCode):
                switch resCode {
                    
                default :
                    print("no 400 rescode")
                    break
                }
                break
                
            case .failure(_):
                completion(.networkFail)
            }
        }
        
    }
}

