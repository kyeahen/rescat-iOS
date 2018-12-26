//
//  PostableService.swift
//  rescat
//
//  Created by 김예은 on 26/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol PostableService {
    associatedtype NetworkData : Codable
    typealias networkResult = (resCode: Int, resResult: NetworkData)
    func post(_ URL: String, params: [String : Any], completion: @escaping (Result<networkResult>) -> Void)
}

extension PostableService {
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
    
    func post(_ URL: String, params: [String : Any], completion: @escaping (Result<networkResult>) -> Void){
        
        guard let encodedUrl = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Networking - invalid URL")
            return
        }
        
        print("URL은 \(encodedUrl)")
        
        let userdefault = UserDefaults.standard
        guard let token = userdefault.string(forKey: "token") else { return }
        
        let token_header = [ "authorization" : token ]
        
        Alamofire.request(encodedUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: token_header).responseData(){
            (res) in
            switch res.result {
            case .success:

                print("Networking Post Here")
                
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
                        print("Error Post")
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

