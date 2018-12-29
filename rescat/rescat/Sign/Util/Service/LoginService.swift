//
//  LoginService.swift
//  rescat
//
//  Created by 김예은 on 26/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation

struct LoginService: PostableService, APIServie {
    
    typealias NetworkData = LoginData
    static let shareInstance = LoginService()
    
    func postLogin(params: [String : Any], completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let loginURL = self.url("auth/login")
        
        post(loginURL, params: params) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.getSuccess.rawValue :
                    let token = networkResult.resResult.token
                    UserDefaultService.setUserDefault(value: token, key: "token")
                    print("서비스에서\(token)")

                    completion(.networkSuccess(networkResult.resResult))
                    
                case HttpResponseCode.serverErr.rawValue :
                    completion(.serverErr)
                    
                default :
                    print("no 201/500 rescode is \(networkResult.resCode)")
                    break
                }
                
                break
                
            case .error(let resCode):
                switch resCode {
                    
                case HttpResponseCode.badRequest.rawValue.description :
                    completion(.badRequest)
                    
                case HttpResponseCode.forbidden.rawValue.description :
                    completion(.wrongInput)
                    
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
