//
//  NSMutableAttributedString+Utils.swift
//  PDAppKit
//
//  Created by Frank Huang on 2019/2/27.
//  Copyright © 2019 Farfetch. All rights reserved.
//

public extension NSMutableAttributedString {

    /// Get the attributed string.
    var attributedString: NSMutableAttributedString {
        return mutableCopy() as! NSMutableAttributedString
    }

    /// Append attributes to string.
    ///
    /// - Parameter attributes: An array contains `Attribtue`.
    func appendAttributes(_ attributes: [Attribute]) {
        let range = NSRange(location: 0, length: length)
        addAttributes(dictionary(from: attributes), range: range)
    }

    /// Append an attribute to string.
    ///
    /// - Parameter attribute: The `Attribute`.
    func appendAttribute(_ attribute: Attribute) {
        appendAttributes([attribute])
    }

    /// Append attributes to string's substring.
    ///
    /// - Parameters:
    ///   - attributes: An array contains `Attribtue`.
    ///   - substring: The substring.
    func appendAttributes(_ attributes: [Attribute], on substring: String) {
        let range = NSString(string: string).range(of: substring)
        addAttributes(dictionary(from: attributes), range: range)
    }

    /// Append an attribute to string's substring.
    ///
    /// - Parameters:
    ///   - attribute: The `Attribute`.
    ///   - substring: The substring.
    func appendAttribute(_ attribute: Attribute, on substring: String) {
        return appendAttributes([attribute], on: substring)
    }
    
    /// Append the given collection of attributes to string's substring.
    ///
    /// - Parameters:
    ///   - attributes: A dictionary containing the attributes to add.
    ///   - substring: The substring.
    func appendAttributes(_ attributes: [NSAttributedString.Key: Any], on substring: String) {
        let range = NSString(string: string).range(of: substring)
        addAttributes(attributes, range: range)
    }
}
