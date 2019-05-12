//
//  Encodable+Utils.swift
//  PDFoundation
//
//  Created by Walker Stark on 2018/11/16.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import Foundation

extension Encodable {

    public var toJSONData: Data? {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601Formatted
            return try encoder.encode(self)
        } catch {
            assertionFailure("HTTP request parameter encode error: \(error)")
        }
        return nil
    }
    
    public var dictionaryRepresentation: [String: Any] {
        guard let jsonData = toJSONData else {
            return [:]
        }

        do {
            guard let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any] else {
                return [:]
            }

            return dictionary
        } catch {
            assertionFailure("Invalid JSON data with error:\(error)")
        }

        return [:]
    }
}
