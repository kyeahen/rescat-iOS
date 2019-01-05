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
    init(_ vc : APIServiceCallback) {
        self.vc = vc
    }
    func addMapData ( _ data : MapRequestModel ) {
//        Alamofire.
    let url = self.url("maps")
        let header : HTTPHeaders = ["Authorization":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJSeWFuZ1QiLCJ1c2VyX2lkeCI6MSwiZXhwIjoxNTQ5MzU0MjI4fQ.5zu9rEA_wGQxBb69lwV_vgAGeDyZbKiG31j1q9ZbHLY",
                      "Content-Type": "application/json"]
        
        let encoder = DictionaryEncoder()
        let param = try! encoder.encode(data) as! [String:Any]

        
     
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header).responseJSON(){
            (res) in
            
            switch res.result {
            case .success:
                
                print("Networking Post Here")
                guard let value = res.result.value else { return }
                print("post success \(value)")
                
                
            case .failure(let err):
                print(err)
                break
            }
        }
    }


    func addPhoto ( _ data : Data ){
        
        let header = ["Authorization":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJSeWFuZ1QiLCJ1c2VyX2lkeCI6MSwiZXhwIjoxNTQ5Mjk2MjU4fQ.Svr3JqKjOzmIFoYN2_XY5AZdVFT70GtL3EnACscWJpE"]
        
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
