//
//  UploadPhotoService.swift
//  rescat
//
//  Created by 김예은 on 07/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation

struct PostImageService : PostablePhtotoService, APIServie {
    
    typealias NetworkData = PhotoData
    static let shareInstance = PostImageService()
    
    func addPhoto(params : [String : Any], image : [String : Data]?, completion : @escaping (NetworkResult<Any>) -> Void){
        
        let photoURL = self.url("photo")
        savePhotoContent(photoURL, params: params, imageData: image) { (result) in
            switch result {
                
            case .success(let networkResult):
                switch networkResult.resCode {
                    
                case HttpResponseCode.postSuccess.rawValue : //201
                    completion(.networkSuccess(networkResult.resResult))
                    
                case HttpResponseCode.accessDenied.rawValue : //401
                    completion(.accessDenied)
                    
                case HttpResponseCode.large.rawValue : //413
                    completion(.large)
                    
                case HttpResponseCode.serverErr.rawValue : //500
                    completion(.serverErr)
                    
                default :
                    print("no 201/401/500 - statusCode is \(networkResult.resCode)")
                    break
                }
                break
                
            case .error(let rescode) :
                
                switch rescode {
                    
                case HttpResponseCode.badRequest.rawValue.description : //400
                    completion(.badRequest)
                    
                case HttpResponseCode.accessDenied.rawValue.description : //401
                    completion(.accessDenied)
                    
                default :
                    print("Error: \(rescode)")
                    break
                }
                break
                
            case .failure(_) :
                completion(.networkFail)
            }
        }
    }
}
