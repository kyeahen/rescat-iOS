import Alamofire
class FundingRequest : APIServie {
    
    var vc : APIServiceCallback
    init(_ vc : APIServiceCallback) {
        self.vc = vc
    }
    func requestMain(){
        
        let header : HTTPHeaders =  ["Authorization" : "123456"]
        let url = self.url("api/fundings/main")
        Alamofire.request(url).responseData { (res) in
            switch res.result{
            case .success :
                guard let fundingList = res.result.value else { return }
                let decoder = JSONDecoder()
                do {
                    let data = try decoder.decode([FundingModel].self, from: fundingList)
                    self.vc.requestCallback(data, APIServiceCode.FUNDING_MAIN)
                } catch {
                    print("decoder error")
                }
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
}
