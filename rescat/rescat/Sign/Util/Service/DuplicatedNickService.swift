//
//  DuplicatedNickService.swift
//  rescat
//
//  Created by 김예은 on 30/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation

struct DuplicatedNickService: PostableService, APIServie {
    
    typealias NetworkData = DefaultData
    static let shareInstance = DuplicatedNickService()
    
    func postDuplicatedNick(nickName: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let loginURL = self.url("users/duplicate/nickname?nickname=\(nickName)")
        
        post(loginURL, params: [:]) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.getSuccess.rawValue : //200
                    
                    completion(.networkSuccess(networkResult.resResult))
                    
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
                    
                case HttpResponseCode.badRequest.rawValue.description :
                    completion(.badRequest)
                    
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

