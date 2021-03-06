import Foundation
import Alamofire
import SwiftyJSON

class Test : APIServie{
    
    
    var v : APIServiceCallback
    init(_ vc : APIServiceCallback) {
        self.v = vc
    }
    func testRequest(){
        let testUrl = "http://13.125.182.116:8090/tests/locations"
        Alamofire.request(testUrl).responseData { (res) in
            switch res.result {
            case .success :
        
                guard let datas = res.result.value else { return }
//                let d = datas as! [String:Any]
//                print(d)
//                print(vv.count)
                let decoder = JSONDecoder()
                do {

                    let data = try decoder.decode([TestModel].self, from: datas)
                    self.v.requestCallback(data, 0)
                }catch {
                    print("decode failure")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

