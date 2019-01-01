protocol APIServie {
    
}

extension APIServie {
    
    func url(_ path: String) -> String {
        return "http://13.209.145.139:8080/api/" + path
    }
  
}





class APIServiceCode {
    static let TEST = 0
    static let FUNDING_MAIN = 100
    static let FUNDING_LIST = 101
    static let FUNDING_BANNER_LIST = 102
    static let FUNDING_DETAIL = 103
    static let FUNDING_COMMENTS = 104
    static let CARE_POST_MAIN = 110
    static let CARE_POST_LIST = 111
    static let BANNER_TYPE = 112
}
