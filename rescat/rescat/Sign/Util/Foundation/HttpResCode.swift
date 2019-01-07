//
//  HttpResCode.swift
//  rescat
//
//  Created by 김예은 on 26/12/2018.
//  Copyright © 2018 kyeahen. All rights reserved.
//

import Foundation
enum HttpResponseCode: Int{
    case getSuccess = 200
    case postSuccess = 201
    case selectErr = 300
    case badRequest = 400
    case accessDenied = 401
    case forbidden = 403
    case conflict = 409
    case large = 413
    case serverErr = 500
    case notImplemented = 501
}

enum Result<T> {
    case success(T)
    case error(String)
    case failure(Error)
}

enum NetworkResult<T> {
    case networkSuccess(T) //200
    case badRequest //400
    case accessDenied //401
    case nullValue //404
    case duplicated //409
    case wrongInput
    case large //413
    case serverErr //500
    case requestFail //501
    case networkFail

}
