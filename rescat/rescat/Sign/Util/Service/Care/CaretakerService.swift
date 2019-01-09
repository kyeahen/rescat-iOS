//
//  CaretakerService.swift
//  rescat
//
//  Created by 김예은 on 07/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation

struct CaretaketService: PostableService, APIServie {
    
    typealias NetworkData = DefaultData
    static let shareInstance = CaretaketService()
    
    //MARK: POST - /api/users/authentications/caretaker(케어테이커 인증)
    func postCaretaker(params: [String : Any], completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let careURL = self.url("users/authentications/caretaker")
        
        post(careURL, params: params) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.postSuccess.rawValue : //201
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
