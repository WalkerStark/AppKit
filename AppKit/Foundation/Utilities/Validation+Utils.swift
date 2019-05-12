//
//  Validation+Utils.swift
//  PDFoundation
//
//  Created by roy.cao on 2018/11/13.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import Foundation

private struct Regex {

    internal let regularExpression: NSRegularExpression

    init(string pattern: String, options: NSRegularExpression.Options = []) {
        do {
            regularExpression = try NSRegularExpression(
                pattern: pattern,
                options: options)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }

    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return regularExpression.firstMatch(in: string, options: [], range: range) != nil
    }
}

extension Regex: ExpressibleByStringLiteral {

    typealias StringLiteralType = String

    init(stringLiteral value: StringLiteralType) {
        self = Regex(string: value)
    }

    public init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }

    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }
}

extension Regex: Equatable {

    public static func == (lhs: Regex, rhs: Regex) -> Bool {
        return lhs.regularExpression == rhs.regularExpression
    }
}

extension Regex: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        regularExpression.hash(into: &hasher)
    }
}

public class Validation {

    private enum RegexTypes: Regex {
        case phone = "^1[3-9]([0-9]){9}$"
        case email = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
    }

    public static func phone(_ str: String) -> Bool {
        return RegexTypes.phone.rawValue.matches(str)
    }

    public static func email(_ str: String) -> Bool {
        return RegexTypes.email.rawValue.matches(str)
    }

    public static func password(_ str: String) -> Bool {
        return str.count >= 6
    }
}
