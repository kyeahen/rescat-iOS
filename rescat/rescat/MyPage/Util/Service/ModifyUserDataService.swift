//
//  ModifyUserDataService.swift
//  rescat
//
//  Created by 김예은 on 07/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation

struct ModifyUserDataService: PuttableService, APIServie {
    
    typealias NetworkData = DefaultData
    static let shareInstance = ModifyUserDataService()
    
    //MARK: PUT - api/users/mypage/edit (회원정보 수정)
    func putModPwd(nickname: String, phone: String, params: [String : Any], completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let dataURL = self.url("users/mypage/edit/password?nickname=\(nickname)&phone=\(phone)")
        
        put(dataURL, params: params) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode {
                    
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
                
            case .failure(_):
                completion(.networkFail)
                print("Fail: Network Fail")
            }
        }
        
    }
}
