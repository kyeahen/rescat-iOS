//
//  Encoder.swift
//  rescat
//
//  Created by jigeonho on 05/01/2019.
//  Copyright © 2019 kyeahen. All rights reserved.
//

import Foundation
import UIKit
extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
class DictionaryEncoder {
    private let jsonEncoder = JSONEncoder()
    
    /// Encodes given Encodable value into an array or dictionary
    func encode<T>(_ value: T) throws -> Any where T: Encodable {
        let jsonData = try jsonEncoder.encode(value)
        return try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
    }
}

class DictionaryDecoder {
    private let jsonDecoder = JSONDecoder()
    
    /// Decodes given Decodable type from given array or dictionary
    func decode<T>(_ type: T.Type, from json: Any) throws -> T where T: Decodable {
        let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
        return try jsonDecoder.decode(type, from: jsonData)
    }
}
