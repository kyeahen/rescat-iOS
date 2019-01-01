//
//  ErrorData.swift
//  rescat
//
//  Created by 김예은 on 30/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation

struct ErrorData: Codable {
    let error: [Err]
}

struct Err: Codable {
    let field: String
    let message: String
}
