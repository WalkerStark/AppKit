//
//  CustomDecoder.swift
//  PDFoundation
//
//  Created by roy.cao on 2019/4/15.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import Foundation

public protocol CustomDecodable { }

extension Data: CustomDecodable { }
extension Array: CustomDecodable where Element == [String: Any] { }
extension Dictionary: CustomDecodable where Key == String { }

public struct CustomDecoder<T: Decodable> {

    public static func decode(_ from: CustomDecodable) -> T? {
        if let data = from as? Data {
            return decode(data)
        }

        do {
            let data = try JSONSerialization.data(withJSONObject: from, options: [])
            return decode(data)
        } catch {
            return nil
        }
    }

    private static func decode(_ data: Data) -> T? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601Formatted
        return try? decoder.decode(T.self, from: data)
    }
}
