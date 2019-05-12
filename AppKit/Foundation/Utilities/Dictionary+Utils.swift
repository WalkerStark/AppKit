//
//  Dictionary+Utils.swift
//  PDAppKit
//
//  Created by Walker Stark on 2018/9/21.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import Foundation

public extension Dictionary {

    func has(key: Key) -> Bool {
        return index(forKey: key) != nil
    }

    /// Remove values contained in the keys parameter from the dictionary.
    ///
    /// var dict : [String : String] = ["key1" : "value1", "key2" : "value2", "key3" : "value3"]
    /// removeValues(keys: ["key1", "key2"])
    /// dict.keys.contains("key3") -> true
    /// dict.keys.contains("key1") -> false
    /// dict.keys.contains("key2") -> false
    mutating func removeValues<S: Sequence>(keys: S) where S.Element == Key {
        keys.forEach { removeValue(forKey: $0) }
    }

    func toJSONData(prettify: Bool = false) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else { return nil }

        let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()

        return try? JSONSerialization.data(withJSONObject: self, options: options)
    }

    func toJSONString(prettify: Bool = false) -> String? {
        guard let jsonData = toJSONData(prettify: prettify) else { return nil }

        return String(data: jsonData, encoding: .utf8)?.replacingOccurrences(of: "\\/", with: "/")
    }

    /// Give a default value if value not found or its type is different.
    /// e.g. Before: let value = (dic[key] as? Int) ?? 0
    ///      Now: let value = dic.value(forKey: key, defaultValue: 0)
    ///
    /// - Parameters:
    ///   - key: The key of dictioanry
    ///   - defaultValue: Default value if value not found or its type is different
    /// - Returns: Default value or exist value
    func value<T>(forKey key: Key, defaultValue: @autoclosure () -> T) -> T {
        guard let value = self[key] as? T else { return defaultValue() }
        return value
    }
}

public extension Dictionary {

    /// Merge keys/values of two dictionaries. If key is conflict, use the second dictionary.
    ///
    /// let dict : [String : String] = ["key1" : "value1"]
    /// let dict2 : [String : String] = ["key2" : "value2"]
    /// let result = dict + dict2
    /// result["key1"] -> "value1"
    /// result["key2"] -> "value2"
    static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        return lhs.merging(rhs) { (_, new) in new }
    }

    /// Merge keys and values from the second dictionary into the first one. If key is conflict, use the second dictionary.
    ///
    /// var dict : [String : String] = ["key1" : "value1"]
    /// let dict2 : [String : String] = ["key2" : "value2"]
    /// dict += dict2
    /// dict["key1"] -> "value1"
    /// dict["key2"] -> "value2"
    static func += (lhs: inout [Key: Value], rhs: [Key: Value]) {
        lhs.merge(rhs) { (_, new) in new }
    }
}

public extension Dictionary {
    /// This computed property returns a query parameters string from the given Dictionary.
    ///
    /// For Example, if the input is ["day": "Tuesday", "month": "January"],
    /// the output string will be "day=Tuesday&month=January".
    /// return The computed parameters string.
    var queryParams: String {
        let parts: [String] = self.map { String(format: "%@=%@", String(describing: $0.key).escaped, String(describing: $0.value).escaped) }
        return parts.joined(separator: "&")
    }
}
