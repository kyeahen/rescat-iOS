//
//  BreedService.swift
//  rescat
//
//  Created by 김예은 on 06/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation

struct BreedService: GettableService, APIServie {
    
    typealias NetworkData = [BreedData]
    static let shareInstance = BreedService()
    
    //MARK: GET - /api/care-posts/breeds(품종 리스트 조회)
    func getBreedList(completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let commentURL = self.url("care-posts/breeds")
        
        get(commentURL) { (result) in
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

