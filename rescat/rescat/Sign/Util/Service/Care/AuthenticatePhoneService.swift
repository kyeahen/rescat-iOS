//
//  AuthenticatePhoneService.swift
//  rescat
//
//  Created by 김예은 on 30/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation

struct AuthenticatePhoneService: PostableService, APIServie {
    
    typealias NetworkData = MessageData
    static let shareInstance = AuthenticatePhoneService()
    
    func postAuthenticatePhone(phone: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let phoneURL = self.url("users/authentications/phone?phone=\(phone)")
        
        post(phoneURL, params: [:]) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.getSuccess.rawValue : //200
                    completion(.networkSuccess(networkResult.resResult.code))
                    
                case HttpResponseCode.badRequest.rawValue : //400
                    completion(.badRequest)
                    
                case HttpResponseCode.serverErr.rawValue : //500
                    completion(.serverErr)
                    
                case HttpResponseCode.notImplemented.rawValue : //501
                    completion(.requestFail)
                    
                default :
                    print("Success: \(networkResult.resCode)")
                    break
                }
                break
                
            case .error(let resCode):
                switch resCode {
                    
                case HttpResponseCode.badRequest.rawValue.description : //400
                    completion(.badRequest)
                    
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
