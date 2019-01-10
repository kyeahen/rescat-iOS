//
//  CarePostRequest.swift
//  rescat
//
//  Created by jigeonho on 10/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class CarePostRequest : APIServie {
    
    var vc : APIServiceCallback
    init(_ vc : APIServiceCallback) {
        self.vc = vc
    }
    func getCarePostMain() {
        let url = self.url("care-posts/main")
        Alamofire.request(url).responseData { (res) in
            switch res.result {
            case .success:
                guard let statusCode = res.response?.statusCode else { return }
                guard let values = res.result.value else { return }
                let decoder = JSONDecoder()
                do {
                    let datas = try decoder.decode([CarePostMainModel].self, from: values)
                    self.vc.requestCallback(datas, APIServiceCode.CARE_POST_MAIN)
                }catch {
                    
                    print("care post decode error")
                }
            case .failure(let error):
                print("failure")
            }
        }
    }
}
