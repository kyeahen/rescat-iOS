//
//  ApplyAdoptService.swift
//  rescat
//
//  Created by 김예은 on 06/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation

struct ApplyAdoptService: PostableService, APIServie {
    
    typealias NetworkData = DefaultData
    static let shareInstance = ApplyAdoptService()
    
    //MARK: POST - api/care-posts/{idx}/applications (입양/임시보호 신청)
    func postApplyAdopt(idx: Int, params: [String : Any], completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let adoptURL = self.url("care-posts/\(idx)/applications")
        
        post(adoptURL, params: params) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.getSuccess.rawValue : //200
                    completion(.networkSuccess(networkResult.resResult))
                    
                case HttpResponseCode.badRequest.rawValue : //400
                    completion(.badRequest)
                    
                case HttpResponseCode.accessDenied.rawValue : //401
                    completion(.accessDenied)
                    
                case HttpResponseCode.badRequest.rawValue : //404
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
                    
                case HttpResponseCode.badRequest.rawValue.description : //404
                    completion(.nullValue)
                    
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
