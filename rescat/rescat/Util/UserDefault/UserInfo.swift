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
    static func getRegions() -> [String] {
        return ["서울특별시 강남구 신사동", "서울특별시 강남구 논현1동", "서울특별시 강남구 논현2동"]
    }
    static func getLocations() -> [[Double:Double]] {
        return [[37.51921427344564:127.02255720149053], [37.518076734351915:127.02757463871035], [127.04271830419171:37.511649039698966]]
    }
    static func getHeader() -> HTTPHeaders {
//        guard let token = UserDefaults.standard.string(forKey: "token") else { return nil }
        
        let header : HTTPHeaders = ["Authorization":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJSeWFuZ1QiLCJ1c2VyX2lkeCI6MTYsImV4cCI6MTU0OTYwMDcxM30.ap7jGUe_3b7-9llpKqe3ruxlsaInWmpYN7B_vgnlJkA"]
        return header
    }

//    static func getKeyboardHeight() -> CGFloat{
//        let keyboardFrame:NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
//        let keyboardRectangle = keyboardFrame.cgRectValue
//        let keyboardHeight = keyboardRectangle.height
//        return keyboardHeight
        
        
//    }
    
}
