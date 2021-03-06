//
//  MyPageSupportService.swift
//  rescat
//
//  Created by 김예은 on 07/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation

struct MyPageSupportService: GettableService, APIServie {
    
    typealias NetworkData = [MyPageSupportData]
    static let shareInstance = MyPageSupportService()
    
    //MARK: GET - /api/users/mypage/fundings(유저가 작성한 후원 글 목록 조회)
    func getMySupportList(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let supportURL = self.url("users/mypage/fundings")
        
        get(supportURL) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode{
                    
                case HttpResponseCode.getSuccess.rawValue: //200
                    completion(.networkSuccess(networkResult.resResult))
                    
                case HttpResponseCode.accessDenied.rawValue: //401
                    completion(.accessDenied)
                    
                case HttpResponseCode.serverErr.rawValue: //500
                    completion(.serverErr)
                    
                default :
                    print("Success: \(networkResult.resCode)")
                    break
                }
                break
                
            case .error(let resCode):
                switch resCode {
                    
                case HttpResponseCode.accessDenied.rawValue.description: //401
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

