import Foundation
import Alamofire
protocol  APIServiceCallback {
    func requestCallback(_ datas : Any )
}
class Test : APIServie{
    
    
    var v : APIServiceCallback
    init(_ vc : APIServiceCallback) {
        self.v = vc
    }
    func testRequest(){
        let testUrl = self.url("tests/location")
        Alamofire.request(testUrl).responseData { (res) in
            switch res.result {
            case .success :
        
                guard let datas = res.result.value else { return }
                let decoder = JSONDecoder()
                do {
                    let data = try decoder.decode([TestModel].self, from: datas)
                    self.v.requestCallback(data)
                }catch {
                    print("decode failure")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

