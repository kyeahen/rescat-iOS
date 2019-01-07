//
//  MapRequest.swift
//  rescat
//
//  Created by jigeonho on 05/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class MapRequest : APIServie {
    var vc : APIServiceCallback
    static var a = 1
    init(_ vc : APIServiceCallback) {
        self.vc = vc
    
    }
    func addMapData ( _ data : MapRequestModel ) {
//        Alamofire.
    let url = self.url("maps")
        let header : HTTPHeaders = ["Authorization":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJSeWFuZ1QiLCJ1c2VyX2lkeCI6MTYsImV4cCI6MTU0OTM4MzcxNX0.r1SUbfDoTnqXPU7NNxZ3mS1uRdp4Xfuwdp_mvmaP4BM",
                      "Content-Type": "application/json"]
        
        let encoder = DictionaryEncoder()
        let param = try! encoder.encode(data) as! [String:Any]

        print("keys \(param.keys.count)")
        
     
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header).responseJSON(){
            (res) in
            switch res.result {
            case .success:
                
                print("Networking Post Here")
                guard let value = res.result.value else { return }
                print("post success \(value)")
                break
                
            case .failure(let err):
                print("post failure \(MapRequest.a)")
                print(err.localizedDescription)
                MapRequest.a += 1
                break
            }
        }
    }
    func getMapList() {
//        let header
        let url = self.url("maps")
        let header : HTTPHeaders = ["Authorization":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJSeWFuZ1QiLCJ1c2VyX2lkeCI6MTYsImV4cCI6MTU0OTM4MzcxNX0.r1SUbfDoTnqXPU7NNxZ3mS1uRdp4Xfuwdp_mvmaP4BM",
                                    "Content-Type": "application/json"]

        
    }


    func addPhoto ( _ data : Data ){
        
        let header = ["Authorization":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJSeWFuZ1QiLCJ1c2VyX2lkeCI6MTYsImV4cCI6MTU0OTM4MzM3NX0.iMXLvLTC86EdPs9Q5c_m0j4Q57Pn32XJwIjIumPa7I4"]
        
        let url = "http://13.209.145.139:8080/api/photo"
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            //            for (key, value) in parameters {
            //                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            //            }
            multipartFormData.append(data, withName: "data", fileName: "image.png", mimeType: "image/png")
            
            
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: header) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    
                    guard let photo = response.result.value else { return }
                
                    let photoUrl = JSON(photo)["photoUrl"]
                    print(photoUrl)
                    self.vc.requestCallback(photoUrl, APIServiceCode.PHOTO_URL)
                    
                    
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
            }
        }
    }
//    func post
}
