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

        let header = UserInfo.getHeader()
        let encoder = DictionaryEncoder()
        let param = try! encoder.encode(data) as! [String:Any]

        print(param)
     
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header).responseData(){
            (res) in
            guard let statusCode = res.response?.statusCode else { return }
            switch res.result {
            case .success:

                guard let value = res.result.value else { return }

                print("Networking Post Here")

                if statusCode == 200 || statusCode == 201 {
                    self.vc.requestCallback(0, APIServiceCode.MARKER_POST)
                } else if statusCode == 400 {
                    self.vc.requestCallback(0, APIServiceCode.EXCEPTION_ERROR1)
                } else if statusCode == 401{
                    self.vc.requestCallback(0, APIServiceCode.EXCEPTION_ERROR2)
                } else {
                    
                }
                
                
            case .failure(let err):
                print("post failure \(MapRequest.a)")
                print(err.localizedDescription)
                MapRequest.a += 1
                break
            }
        }
    }
    func getMapList( _ emdCode : Int) {
//        let header
        let url = self.url("maps?emdCode=\(emdCode)")
        let header = UserInfo.getHeader()
        Alamofire.request(url, headers: header).responseData { (res) in
            switch res.result{
            case .success:
                
                guard let code = res.response?.statusCode else { return }
                guard let datas = res.result.value else { return }
                
                print("펀딩 rescode\(res)")
                if code == 200 {
                    let decoder = JSONDecoder()
                    do {
                        let markers = try decoder.decode([MarkerModel].self, from: datas)
                        self.vc.requestCallback(markers, APIServiceCode.MARKER_LIST)
                    } catch {
                        print("marker list decode failure")
                    }
                } else if code == 401 {
                    print("마커불러오기 권하없음")
                } else if code == 500 {
                    print("마일리지 서버에러")
                    self.vc.requestCallback(-1, APIServiceCode.SERVER_ERROR)
                }
                
            case .failure(let error):
                print("post funding Milege failure")
            }
        }
       
    }


    func addPhoto ( _ data : Data ){
        
        let header = UserInfo.getHeader()

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
