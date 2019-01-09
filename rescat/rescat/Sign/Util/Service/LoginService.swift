//
//  LoginService.swift
//  rescat
//
//  Created by 김예은 on 26/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation

struct LoginService: PostableService, APIServie {
    
    typealias NetworkData = TokenData
    static let shareInstance = LoginService()
    
    //MARK: POST - /api/users/login (유저 로그인)
    func postLogin(params: [String : Any], completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let loginURL = self.url("users/login")
        
        post(loginURL, params: params) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.getSuccess.rawValue : //200
                    UserDefaults.standard.set(networkResult.resResult.token, forKey: "token")
                    let token = UserDefaults.standard.string(forKey: "token")
                    print("토큰: \(token)")
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
