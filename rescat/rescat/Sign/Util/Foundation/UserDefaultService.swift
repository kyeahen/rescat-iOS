//
//  UserDefaultService.swift
//  rescat
//
//  Created by 김예은 on 27/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation

struct UserDefaultService {
    
    //MARK: UserDefault 값 설정
    static func setUserDefault(value: Any, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    //MARK: UserDefault 값 얻기
    static func getUserDefault(key: String) -> Any {
        guard let value = UserDefaults.standard.object(forKey: key) else { return "-1" }
        
        return value
    }
}
