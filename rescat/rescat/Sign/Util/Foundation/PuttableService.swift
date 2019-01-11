//
//  PuttableService.swift
//  rescat
//
//  Created by 김예은 on 06/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol PuttableService {
    
    associatedtype NetworkData : Codable
    typealias networkResult = (resCode: Int, resResult: NetworkData)
    func put(_ URL: String, params: [String : Any], completion: @escaping (Result<networkResult>) -> Void)
}

extension PuttableService {
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
    
    func put(_ URL: String, params: [String : Any], completion: @escaping (Result<networkResult>) -> Void){
        
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
        
        Alamofire.request(encodedUrl, method: .put, parameters: params, encoding: JSONEncoding.default, headers: token_header).responseData(){
            (res) in
            
            switch res.result {
            case .success:
                
                print("Networking Put Here")
                print(params)
                
                if let value = res.result.value {
                    let resCode = self.gino(res.response?.statusCode)
                    print(resCode)
                    
                    print(JSON(value))
                    
                    //성공 모델
                    if JSON(value) == JSON.null {
                        
                        let result : networkResult = (resCode, DefaultData()) as! (resCode: Int, resResult: Self.NetworkData)
                        completion(.success(result))
                        break
                        
                    }
                    
                    let decoder = JSONDecoder()
                    
                    //실패 모델
                    do {
                        
                        let resData = try decoder.decode(NetworkData.self, from: value)
                        
                        let result : networkResult = (resCode, resData)
                        
                        completion(.success(result))
                    }catch{ //변수 문제 예외 예상
                        print("Catch Put")
                        
                        
                        completion(.error("\(resCode)"))
                    }
                }
                break
                
            case .failure(let err):
                print(err.localizedDescription)
                completion(.failure(err))
                break
            }
        }
        
        
    }
}

