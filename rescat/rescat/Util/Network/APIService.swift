protocol APIServie {
    
}
import Alamofire
import UIKit
import SwiftyJSON
extension APIServie {
    
    func url(_ path: String) -> String {
        return "http://13.209.145.139:8080/api/" + path
    }
    
   
  
}





class APIServiceCode {
    static let TEST = 0
    static let SERVER_ERROR = 1
    static let PARAMENTER_ERROR = 2
    static let EXCEPTION_ERROR1 = 3
    static let EXCEPTION_ERROR2 = 4

    static let PHOTO_URL = 99
    static let FUNDING_MAIN = 100
    static let FUNDING_LIST = 101
    static let FUNDING_BANNER_LIST = 102
    static let FUNDING_DETAIL = 103
    static let FUNDING_COMMENTS = 104
    static let FUNDING_MY_COMMENT = 105
    static let FUNDING_RANDOM_BANNER = 107
    static let FUNDING_BOTTOM_BANNER_LIST = 109
    static let FUNDING_COMMENT_DELETE = 110
    static let FUNDING_DETAIL_POST = 111
    static let FUNDING_MIELGE_POST = 112
    static let FUNDING_BANK_LIST = 113
    static let CARE_POST_MAIN = 114
    static let CARE_POST_LIST = 121
    static let BANNER_TYPE = 122
    static let MARKER_POST = 130
    static let MARKER_LIST = 131
    static let GEOCODE = 140
    static let REVERSE_GEOCODE = 141
}
