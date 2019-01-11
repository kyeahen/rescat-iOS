//
//  JoinService.swift
//  rescat
//
//  Created by 김예은 on 30/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation

struct JoinService: PostableService, APIServie {
    
    typealias NetworkData = TokenData
    static let shareInstance = JoinService()
    
    //MARK: POST - /api/users (일반 유저 생성)
    func postJoin(params: [String : Any], completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let joinURL = self.url("users")
        
        post(joinURL, params: params) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.postSuccess.rawValue : //201
                    UserDefaults.standard.set(networkResult.resResult.token, forKey: "token")
                    let token = UserDefaults.standard.string(forKey: "token")
                    print("토큰: \(token)")
                    completion(.networkSuccess(networkResult.resResult))
                    
                case HttpResponseCode.badRequest.rawValue : //400
                    completion(.badRequest)
                    
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
                    
                case HttpResponseCode.conflict.rawValue.description : //409
                    completion(.duplicated)
                    
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

