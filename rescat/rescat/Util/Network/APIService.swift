protocol APIServie {
    
}

extension APIServie {
    
    func url(_ path: String) -> String {
        return "http://13.125.182.116:8090/" + path
    }
  
}
