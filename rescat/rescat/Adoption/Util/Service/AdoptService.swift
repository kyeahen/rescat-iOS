//
//  AdoptService.swift
//  rescat
//
//  Created by 김예은 on 02/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation

struct AdoptService: GettableService, APIServie {
    
    typealias NetworkData = [AdoptData]
    static let shareInstance = AdoptService()
    
    //MARK: GET - /api/care-posts (입양 글 리스트 또는 임시보호 글 리스트 조회)
    func getAdoptList(type: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let adoptURL = self.url("care-posts?type=\(type)")
        
        get(adoptURL) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode{
                    
                case HttpResponseCode.getSuccess.rawValue: //200
                    completion(.networkSuccess(networkResult.resResult))
                    
                case HttpResponseCode.serverErr.rawValue: //500
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
                    
                case HttpResponseCode.conflict.rawValue.description : //409
                    completion(.duplicated)
                    
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

