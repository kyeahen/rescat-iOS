//
//  AcceptAdoptService.swift
//  rescat
//
//  Created by 김예은 on 11/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation

struct AceceptAdoptService: PostableService, APIServie {
    
    typealias NetworkData = DefaultData
    static let shareInstance = AceceptAdoptService()
    
    //MARK: POST - /api/care-posts/applications/{idx}/accepting (입양/임시보호 신청 승낙)
    
    func postAccepdAdopt(idx: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let acceptURL = self.url("care-posts/applications/\(idx)/accepting")
        
        post(acceptURL, params: [:]) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.postSuccess.rawValue : //201
                    completion(.networkSuccess(networkResult.resResult))
                    
                case HttpResponseCode.badRequest.rawValue : //400
                    completion(.badRequest)
                    
                case HttpResponseCode.accessDenied.rawValue : //401
                    completion(.accessDenied)
                    
                case HttpResponseCode.nullValue.rawValue : //404
                    completion(.nullValue)

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
                    
                case HttpResponseCode.nullValue.rawValue.description : //404
                    completion(.nullValue)

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
