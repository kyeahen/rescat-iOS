import Foundation
import Alamofire
import UIKit
class UserInfo {
    
    static func setLocation( _ address : [String]) {
        // 새로운 지역 등록
        // 없으면 새롭게 등록
        let d = UserDefaults.standard.object(forKey: "myplaces")
//        guard let places = d as! NSDictionary else { return }
        
        // 3개가 넘어가면 error
    }
    static func getLocation() -> [[String:Int]] {
        return [["서울특별시 강남구 신사동":1123051], ["서울특별시 강남구 논현1동":1123052],["서울특별시 강남구 논현2동":1123053]]
    }
//    static func getRegions() -> [String] {
//        return ["서울특별시 강남구 신사동", "서울특별시 강남구 논현1동", "서울특별시 강남구 논현2동"]
//    }
//    static func getLocations() -> [[Double:Double]] {
//        return [[37.51921427344564:127.02255720149053], [37.518076734351915:127.02757463871035], [127.04271830419171:37.511649039698966]]
//    }
    static func getHeader() -> HTTPHeaders {
        
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            let header : HTTPHeaders = [:]
            return header
        }
        let header : HTTPHeaders = ["Authorization": token]
        return header
    }
    static let notMessage = "회원가입을 하고 케어테이커 인증을 하면, \n우리 동네 길냥이, 배식소, 병원 정보를\n한 눈에 확인할 수 있어요."
    static let memberMessage = "케어테이커 인증을 하면,\n우리 동네 길냥이, 배식소, 병원 정보를\n한 눈에 확인할 수 있어요."

    
}
