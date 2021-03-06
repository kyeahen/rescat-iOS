//
//  CommentWarningService.swift
//  rescat
//
//  Created by 김예은 on 09/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation

struct CommentWarningService: PostableService, APIServie {
    
    typealias NetworkData = DefaultData
    static let shareInstance = CommentWarningService()
    
    //MARK: POST - /api/care-posts/{idx}/comments/{comment-idx}/warning (댓글 신고)
    func postWarnComment(idx: Int, cId: Int, params: [String : Any], completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let warnURL = self.url("care-posts/\(idx)/comments/\(cId)/warning")
        
        post(warnURL, params: params) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.getSuccess.rawValue : //200
                    completion(.networkSuccess(networkResult.resResult))
                    
                case HttpResponseCode.badRequest.rawValue : //400
                    completion(.badRequest)
                    
                case HttpResponseCode.accessDenied.rawValue : //401
                    completion(.accessDenied)
                    
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
                    
                case HttpResponseCode.accessDenied.rawValue.description : //401
                    completion(.accessDenied)
                    
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
