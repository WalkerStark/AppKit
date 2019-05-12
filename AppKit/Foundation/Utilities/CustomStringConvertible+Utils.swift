//
//  CustomStringConvertible+Utils.swift
//  PDFoundation
//
//  Created by Walker Stark on 2019/2/21.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import Foundation

extension CustomStringConvertible {

    public var collectionRepresentation: Any? {
        if let data = self as? Data, let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) {
            return jsonObject
        }

        if let data = "\(self)".data(using: .utf8), let dict = try? JSONSerialization.jsonObject(with: data, options: []) {
            return dict
        }

        var dict: [String: Any] = [:]
        let mirror = Mirror(reflecting: self)

        for case let (label?, value) in mirror.children {
            // swiftlint:disable syntactic_sugar
            guard case Optional<Any>.some(let rawValue) = value else { continue }

            dict[label] = "\(rawValue)"
        }

        return dict.isEmpty ? nil : dict
    }
    
    public var description: String {
        var dict: [String: Any] = [:]
        let mirror = Mirror(reflecting: self)
        
        for case let (label?, value) in mirror.children {
            // swiftlint:disable syntactic_sugar
            guard case Optional<Any>.some(let rawValue) = value else { continue }

            if rawValue is [String: Any] || rawValue is [[String: Any]] {
                dict[label] = rawValue
            } else if let value = rawValue as? NSObject, value.isRealObjCObject {
                dict[label] = value.dictionaryRepresentation.isEmpty ? "\(value)" : value.dictionaryRepresentation
            } else if let value = rawValue as? CustomStringConvertible {
                dict[label] = value.collectionRepresentation ?? "\(rawValue)"
            } else {
                dict[label] = "\(rawValue)"
            }
        }
        
        return dict.toJSONString(prettify: true) ?? "nil"
    }
}
