protocol APIServie {
    
}

extension APIServie {
    
    func url(_ path: String) -> String {
        return "http://13.209.145.139:8080/" + path
    }
  
}





class APIServiceCode {
    static let TEST = 0
    static let FUNDING_MAIN = 100
    static let FUNDING_LIST = 101
    static let CARE_POST_MAIN = 102
    static let CARE_POST_LIST = 103
    static let BANNER_TYPE = 104
}
