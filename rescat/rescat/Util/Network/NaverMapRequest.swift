//
//  ReverseGeocoderRequest.swift
//  rescat
//
//  Created by jigeonho on 30/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class NaverMapRequest : APIServie {
    
    var vc : APIServiceCallback
    init(_ vc : APIServiceCallback) {
        self.vc = vc
    }
    func requestReverseGeocoder( _ lat : Double, _ long : Double) {
        
        let header : HTTPHeaders = [
            "Content-Type": "application/json",
            "X-NCP-APIGW-API-KEY-ID" : MapAPIKey.reverseGeocodeClientKey,
            "X-NCP-APIGW-API-KEY" : MapAPIKey.reverseGeocodeKey ]

        let url = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=\(long),\(lat)&sourcecrs=epsg:4326&output=json&orders=addr,admcode"
        let encodedUrl : URL = URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!

        Alamofire.request(encodedUrl, headers: header).responseData { (res) in
            
            switch res.result{
            case .success:
                print("reverse success")
                guard let data = res.result.value else { return }
                
                let json = JSON(data)
                let area1 = json["results"][0]["region"]["area1"]["name"]
                let area2 = json["results"][0]["region"]["area2"]["name"]
                let area3 = json["results"][0]["region"]["area3"]["name"]
                let result = "\(area1) \(area2) \(area3)"
                
                self.vc.requestCallback(result, 2)
            case .failure(let error):
                print(error)
                
                print("naver reverse geocoder request faulure")
            }
        }
       
        
    }
    func requestGeocoder( _ address : String ) {
        
        print("requestGEocode \(address)")
        let header : HTTPHeaders = [
            "Content-Type": "application/json",
            "X-NCP-APIGW-API-KEY-ID" : MapAPIKey.geocodeClientKey,
                       "X-NCP-APIGW-API-KEY" : MapAPIKey.geocodeKey ]
        let url = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=\(address)"
        let encodedUrl : URL = URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        Alamofire.request(encodedUrl, headers : header).responseData { (res) in
            switch res.result{
            case .success:
                guard let data = res.result.value else { return }
                let json = JSON(data)
                let long = json["addresses"][0]["x"]
                let lat = json["addresses"][0]["y"]
                let add = "\(lat) \(long)"
                print("add - \(add)")
                self.vc.requestCallback(add, APIServiceCode.GEOCODE)
            case .failure(let error):
                print("naver geocoder request failure error - \(error)")
            }
        }
    }
}
