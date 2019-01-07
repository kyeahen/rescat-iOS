//
//  PostBoxListService.swift
//  rescat
//
//  Created by 김예은 on 08/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation

struct PostBoxListService: GettableService, APIServie {
    
    typealias NetworkData = [PostBoxListData]
    static let shareInstance = PostBoxListService()
    
    //MARK: GET - /api/users/mypage/notification-box (우체통 조회)
    func getPostBoxInit(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let editURL = self.url("users/mypage/notification-box")
        
        get(editURL) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode{
                    
                case HttpResponseCode.getSuccess.rawValue : //200
                    completion(.networkSuccess(networkResult.resResult))
                    
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
                    
                case HttpResponseCode.accessDenied.rawValue.description : //401
                    completion(.accessDenied)
                    
                default :
                    print("Error: \(resCode)")
                    break
                }
                break
                
            case .failure(_) :
                completion(.networkFail)
                print("Fail: Network Fail")
            }
        }
    }
}
