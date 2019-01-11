import Alamofire
import SwiftyJSON
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
                
                guard let statusCode = res.response?.statusCode else { return }
                if statusCode == 500 {
                    self.vc.requestCallback(1, APIServiceCode.SERVER_ERROR)
                } else if ( statusCode == 200){

                    guard let fundingList = res.result.value else { return }
                    let decoder = JSONDecoder()
                    do {
                        let data = try decoder.decode([FundingModel].self, from: fundingList)
                        self.vc.requestCallback(data, APIServiceCode.FUNDING_MAIN)
                    } catch {
                        print("[FundingModel] main decoder error")
                    }

                }
                
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    func requestList( _ type : Int) {
        let url = self.url("fundings?category=\(type)")
        let header = UserInfo.getHeader()
        Alamofire.request(url, headers: header).responseData { (res) in
            switch res.result{
            case .success:
                guard let statusCode = res.response?.statusCode else { return }
                if statusCode == 500 {
                    self.vc.requestCallback(1, APIServiceCode.SERVER_ERROR)
                } else if ( statusCode == 200){
               
                    guard let fundinglist = res.result.value else { return }
                    let decoder = JSONDecoder()
                    do {
                        let datas = try decoder.decode([FundingModel].self, from: fundinglist)
                        self.vc.requestCallback(datas, APIServiceCode.FUNDING_LIST)
                    } catch {
                        print("[FundingModel] list decoder error")
                    }
                    
                }
                
               
            case .failure(let error):
                print(error)
            }
        }
    }
   
    func requestFundingBannerList(_ type : Int) {
        // 0 : 상위 펀딩 후기 배너 4개, 1 : 가운데 랜덤 배너 광고 배너, 2 : 하단 광고 배너 4개
        var url = ""
        if type == 0 {
            url = self.url("banners/funding-reviews")
        } else if type == 1 {
            url = self.url("banners/advertisement/random")
        } else {
            url = self.url("banners/advertisement")
        }
        Alamofire.request(url).responseData { (res) in
            switch res.result {
            case .success :
                
                guard let statusCode = res.response?.statusCode else { return }
                if statusCode == 500 {
                    self.vc.requestCallback(1, APIServiceCode.SERVER_ERROR)
                } else if ( statusCode == 200){
                  
                    guard let fundingBannerList = res.result.value else { return }
                    let decoder = JSONDecoder()
                    do {
                        
                        if type == 0 {
                            let datas = try decoder.decode([FundingBannerModel].self, from: fundingBannerList)
                            self.vc.requestCallback(datas, APIServiceCode.FUNDING_BANNER_LIST)
                        } else if type == 1 {
                            let datas = try decoder.decode(FundingBannerModel.self, from: fundingBannerList)
                            self.vc.requestCallback(datas, APIServiceCode.FUNDING_RANDOM_BANNER)
                        } else {
                            let datas = try decoder.decode([FundingBannerModel].self, from: fundingBannerList)
                            self.vc.requestCallback(datas, APIServiceCode.FUNDING_BOTTOM_BANNER_LIST)
                        }
                        
                    } catch {
                        print("funding banner list decode failure")
                    }
                    
                }else if statusCode == 500 {
                    self.vc.requestCallback("", APIServiceCode.SERVER_ERROR)
                }
               
            case .failure(let error):
                print("funding banner request error \(error)")
            }
        }
    }
    func requestFundingDetail( _ idx : Int) {
        let header = UserInfo.getHeader()
        let url = self.url("fundings/\(idx)")
        Alamofire.request(url, headers : header).responseData { (res) in
            switch res.result {
            case .success:
                
                guard let statusCode = res.response?.statusCode else { return }
                if statusCode == 500 {
                    self.vc.requestCallback(1, APIServiceCode.SERVER_ERROR)
                } else if ( statusCode == 200){
                    
                    
                }
                guard let fundingdetail = res.result.value else { return }
                let decoder = JSONDecoder()
                do {
                    let data = try decoder.decode(FundingDetailModel.self, from: fundingdetail)
//                    print(data)
                    self.vc.requestCallback(data, APIServiceCode.FUNDING_DETAIL)
                } catch {
                    print("funding detail decode failure")
                }
            case .failure(let error):
                print("funding detail request error - \(error)")
            }
    
            
        }
    }
    func requestFundingCommentDelete( _ idx: Int , _ comment_idx : Int ) {
        
        let header = UserInfo.getHeader()
        let url = self.url("fundings/\(idx)/comments/\(comment_idx)")
        Alamofire.request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (res) in
            switch res.result{
            case .success:
                guard let statusCode = res.response?.statusCode else { return }
                if statusCode == 500 {
                    self.vc.requestCallback(1, APIServiceCode.SERVER_ERROR)
                } else if ( statusCode == 200){
                    
                }
                print("삭제성공")
            case .failure(let erorr):
                print("funding delete request failure")
                
            }
        }
    }
    func requestFundingComments( _ idx : Int) {
        
        let header = UserInfo.getHeader()
        let url = self.url("fundings/\(idx)/comments")
        
        Alamofire.request(url, headers: header).responseData { (res) in
            switch res.result {
            case .success:
                guard let statusCode = res.response?.statusCode else { return }
                if statusCode == 500 {
                    self.vc.requestCallback(1, APIServiceCode.SERVER_ERROR)
                } else if ( statusCode == 200){
                    
                    
                }
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

    func postFundingComment( _ comment : String, _ idx : Int ) {
        
        let url = self.url("fundings/\(idx)/comments")
        let header = UserInfo.getHeader()
        
        let c : FundingCommentModel = FundingCommentModel(); c.contents = comment
        let encoder = DictionaryEncoder()
        let param = try! encoder.encode(c) as! [String:Any]
        
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header).responseData(){
            (res) in
            switch res.result {
            case .success:
                guard let statusCode = res.response?.statusCode else { return }
                if statusCode == 500 {
                    self.vc.requestCallback(1, APIServiceCode.SERVER_ERROR)
                } else if ( statusCode == 200){
                    
                    
                }
                guard let datas = res.result.value else { return }
                let decoder = JSONDecoder()
                do {
                    let mycomment = try decoder.decode(FundingCommentModel.self, from: datas)
                    self.vc.requestCallback(mycomment, APIServiceCode.FUNDING_MY_COMMENT)
                } catch {
                    print("funding post comment decode failure")
                }
                
            case .failure(let err):
                print("comment post failure ")
                print(err.localizedDescription)
                break
            }
        }
    }
    func postFundingDetail ( _ model : FundingRequestModel ) {
        
        let header = UserInfo.getHeader()
        let url = self.url("fundings")
        let encoder = DictionaryEncoder()
        let param = try! encoder.encode(model) as! [String:Any]

        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header).responseData { (res) in
            switch res.result {
            case .success:
               
                if let value = res.result.value {
                    
                    guard let statusCode = res.response?.statusCode else { return }
                    
                    if statusCode == 500 {
                        print("internal error")
                        self.vc.requestCallback(1, APIServiceCode.SERVER_ERROR)
                    } else if  statusCode == 200{
                        
                        print("success")
                        guard let data = res.result.value else { return }
                        print("funding detail post result - \(data)")
                        self.vc.requestCallback(data, APIServiceCode.FUNDING_DETAIL_POST)
                        
                    } else if statusCode == 400{
                       
                        let decoder = JSONDecoder()
                        do {
                            let banks = try decoder.decode([FundingRequestExceptionModel].self, from: value)
                            self.vc.requestCallback(banks, APIServiceCode.EXCEPTION_ERROR1)
                        } catch {
                            print("[FundingModel] main decoder error")
                        }

                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                print("funding detail post failure")
                
                
            }
        }
        
    }
    func getBankList(){
        
        let url = self.url("fundings/banks")
        Alamofire.request(url).responseData { (res) in
            switch res.result {
            case .success:
                guard let statusCode = res.response?.statusCode else { return }
                if statusCode == 500 {
                    self.vc.requestCallback(1, APIServiceCode.SERVER_ERROR)
                } else if ( statusCode == 200){
                    
                    
                }
                guard let datas = res.result.value else { return }
                let decoder = JSONDecoder()
                do {
                    let banks = try decoder.decode([FundingBankModel].self, from: datas)
                    self.vc.requestCallback(banks, APIServiceCode.FUNDING_BANK_LIST)
                } catch {
                    print("[FundingModel] main decoder error")
                }

            case .failure(let error):
                print("bank list request failure")
            }
        }
    }
    func postFundingMileage ( _ idx : Int, mileage : Int ){
        
        print("마일리지 게시글 \(idx)")
        let header = UserInfo.getHeader()
        let url = self.url("fundings/\(idx)/pay")
        let param = ["mileage":mileage]
        Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header).responseJSON { (res) in
            switch res.result {
            case .success:
          
                guard let code = res.response?.statusCode else { return }
                
                if code == 200 {
                    self.vc.requestCallback(10, APIServiceCode.FUNDING_MIELGE_POST)
                } else if code == 400 {
                    print("마일리지가부족")
                    self.vc.requestCallback(10, APIServiceCode.EXCEPTION_ERROR1)
                } else if code == 500 {
                    print("마일리지 서버에러")
                    self.vc.requestCallback(-1, APIServiceCode.SERVER_ERROR)
                }
                
            case .failure(let error):
                print("post funding Milege failure")
            }
        }
    }
    

}
