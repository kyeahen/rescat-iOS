import Alamofire
class FundingRequest : APIServie {
    
    var vc : APIServiceCallback
    init(_ vc : APIServiceCallback) {
        self.vc = vc
    }
    func requestMain(){
        
//        let header : HTTPHeaders =  ["Authorization" : "123456"]
        let url = self.url("fundings/main")
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
    func requestList( _ type : Int) {
        let url = self.url("fundings?category=\(type)")
//        let header : HTTPHeaders = []
        Alamofire.request(url).responseData { (res) in
            switch res.result{
            case .success:
                guard let fundinglist = res.result.value else { return }
                let decoder = JSONDecoder()
                do {
                    let datas = try decoder.decode([FundingModel].self, from: fundinglist)
                    self.vc.requestCallback(datas, APIServiceCode.FUNDING_LIST)
                } catch {
                    print("decoder error")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    func requestFundingBannerList() {
        let url = self.url("funding-banners")
        Alamofire.request(url).responseData { (res) in
            switch res.result {
            case .success :
                
                guard let fundingBannerList = res.result.value else { return }
                let decoder = JSONDecoder()
                do {
                    let datas = try decoder.decode([FundingBannerModel].self, from: fundingBannerList)
                    self.vc.requestCallback(datas, APIServiceCode.FUNDING_BANNER_LIST)
                } catch {
                    print("funding banner list decode failure")
                }
            case .failure(let error):
                print("funding banner request error \(error)")
            }
        }
    }
    func requestFundingDetamil( _ idx : Int) {
        let url = self.url("fundings/\(idx)")
        Alamofire.request(url).responseData { (res) in
            switch res.result {
            case .success:
                
                guard let fundingdetail = res.result.value else { return }
                let decoder = JSONDecoder()
                do {
                    let data = try decoder.decode(FundingDetailPhoto.self, from: fundingdetail)
                    self.vc.requestCallback(data, APIServiceCode.FUNDING_DETAIL)
                } catch {
                    print("funding detail decode failure")
                }
            case .failure(let error):
                print("funding detail request error - \(error)")
            }
    
            
        }
    }
    func requestFundingComments( _ idx : Int) {
        let url = self.url("fundings/\(idx)/comments")
        Alamofire.request(url).responseData { (res) in
            switch res.result {
            case .success:
                guard let comments = res.result.value else { return }
                let decoder = JSONDecoder()
                do {
                    let datas = try decoder.decode([FundingCommentModel].self, from: comments)
                    self.vc.requestCallback(datas, APIServiceCode.FUNDING_COMMENTS)
                } catch {
                    print("funding comments decode failure")
                }
            case .failure(let error):
                print("funding comments request error - \(error)")
            }
        
        }
    }

}
