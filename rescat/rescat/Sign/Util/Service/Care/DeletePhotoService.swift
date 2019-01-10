//
//  DeletePhotoService.swift
//  rescat
//
//  Created by 김예은 on 08/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation

struct DeletePhotoService: DeletableService, APIServie {
    
    typealias NetworkData = DefaultData
    static let shareInstance = DeletePhotoService()
    
    //MARK: Delete - /api/photo (댓글 삭제)
    func deletePhoto(photoUrl: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        let deleteURL = self.url("photo?photoUrl=\(photoUrl)")
        
        delete(deleteURL, params: [:]) { (result) in
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
