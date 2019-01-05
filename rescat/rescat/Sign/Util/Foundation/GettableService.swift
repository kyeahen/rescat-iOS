//
//  GettableService.swift
//  rescat
//
//  Created by 김예은 on 26/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol GettableService {
    
    associatedtype NetworkData : Codable
    typealias networkResult = (resCode: Int, resResult: NetworkData)
    func get(_ URL: String, method: HTTPMethod, completion: @escaping (Result<networkResult>) -> Void)
    
}

extension GettableService {
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
    
    func get(_ URL: String, method: HTTPMethod = .get, completion: @escaping (Result<networkResult>) -> Void){
        
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
        print("이게 나의 토큰 \(token)")

        Alamofire.request(encodedUrl, method: method, parameters: nil, headers: nil).responseData {(res) in

            switch res.result {
                
            case .success :
                if let value = res.result.value {
                    
                    print("Networking Get Here!")
                    print(JSON(value))
                    
                    let resCode = self.gino(res.response?.statusCode)
                    print(resCode)
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        print("들감")
                        let data = try decoder.decode(NetworkData.self, from: value)
                        
                        let result : networkResult = (resCode, data)
                        completion(.success(result))
                        
                    }catch{
                        print("Catch GET")
                        completion(.error("\(resCode)"))
                    }
                }
                break
            case .failure(let err) :
                print(err.localizedDescription)
                completion(.failure(err))
                break
            }
            
        }
    }
    
}

