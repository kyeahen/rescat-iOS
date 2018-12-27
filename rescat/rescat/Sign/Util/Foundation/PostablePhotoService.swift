//
//  PostablePhotoService.swift
//  rescat
//
//  Created by 김예은 on 27/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

//TODO: 테스트 필요
protocol PostablePhotoService {
    
    associatedtype NetworkData : Codable
    typealias networkResult = (resCode: Int, resResult: NetworkData)
    func postPhoto(_ URL: String, params: [String : Any], completion: @escaping (Result<networkResult>) -> Void)
}

extension PostablePhotoService {
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
    
    func postPhoto(_ URL: String, image: UIImage, completion: @escaping (Result<networkResult>) -> Void) {

        
        guard let encodedUrl = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Networking - invalid URL")
            return
        }
        
        print("URL은 \(encodedUrl)")
        
        let token = UserDefaults.standard.string(forKey: "token") ?? "-1"
        
        var token_header: HTTPHeaders?
        if token != "-1" {
            token_header = [ "authorization" : token ]
        } else {
            token_header = nil
        }
        
        guard let imageData = image.jpegData(compressionQuality: 0.3) else { return }
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            multipartFormData.append(imageData, withName: "photo", fileName: "image.jpg", mimeType: "image/jpg")
            
        }, to: URL, method: .post, headers: token_header) { (encodingResult) in
            
            switch encodingResult {
                
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _) :
                
                upload.responseData(completionHandler: {(res) in
                    
                    switch res.result {
                    case .success:
                        
                        print("Networking Post Photo Here")
                        
                        if let value = res.result.value {
                            let resCode = self.gino(res.response?.statusCode)
                            print(resCode)
                            
                            print(JSON(value))
                            
                            if JSON(value) == JSON.null {
                                let result : networkResult = (resCode, DefaultData()) as! (resCode: Int, resResult: Self.NetworkData)
                                completion(.success(result))
                                break
                            }
                            
                            let decoder = JSONDecoder()
                            
                            do {
                                let data = try decoder.decode(NetworkData.self, from: value)
                                
                                let result : networkResult = (resCode, data)
                                completion(.success(result))
                            }catch{
                                print("Error Post Photo")
                                completion(.error("\(resCode)"))
                            }
                        }
                        
                        break
                        
                        
                    case .failure(let err):
                        
                        print(err.localizedDescription)
                        completion(.failure(err))
                        break
                    }
                })
                
                break
                
            case .failure(let err):
                print(err.localizedDescription)
                completion(.failure(err))
            }
            
        }
    }
    
    
    
    
}


