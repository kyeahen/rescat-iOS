//
//  DetailWarningService.swift
//  rescat
//
//  Created by 김예은 on 09/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation

struct DetailWarningService: PostableService, APIServie {
    
    typealias NetworkData = DefaultData
    static let shareInstance = DetailWarningService()
    
    //MARK: POST - /api/care-posts/{idx}/warning (상세보기 신고)
    func postWarnDetail(idx: Int, params: [String : Any], completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let warnURL = self.url("care-posts/\(idx)/warning")
        
        post(warnURL, params: params) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.getSuccess.rawValue : //201
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
