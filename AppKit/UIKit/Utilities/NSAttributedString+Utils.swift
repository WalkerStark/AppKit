//
//  NSAttributedString+Utils.swift
//  PDFoundation
//
//  Created by Frank Huang on 2019/1/8.
//  Copyright © 2019 Farfetch. All rights reserved.
//

public func dictionary(from attributes: [Attribute]) -> [AttributeName: Any] {
    var dict = [AttributeName: Any]()
    for attribute in attributes {
        dict[attribute.keyName] = attribute.foundationValue
    }
    return dict
}

public extension NSAttributedString {

    /// Create a new 'NSAttributedString' with specified `Attribute`.
    ///
    /// - Parameters:
    ///   - str: The string for attributes.
    ///   - attrs: An array contains `Attribtue`.
    convenience init(string str: String, attrs: [Attribute]) {
        self.init(string: str, attributes: dictionary(from: attrs))
    }

    /// Append attributes to string and return an attributed string.
    ///
    /// - Parameter attributes: An array contains `Attribtue`.
    /// - Returns: `NSAttributedString` with specified `Attribute`.
    func appendedAttributes(_ attributes: [Attribute]) -> NSAttributedString {
        let range = NSRange(location: 0, length: length)
        let mutableAttriString = mutableCopy() as! NSMutableAttributedString
        mutableAttriString.addAttributes(dictionary(from: attributes), range: range)
        return mutableAttriString
    }

    /// Append attribute to string and return an attributed string.
    ///
    /// - Parameter attribute: The `Attribute`.
    /// - Returns: `NSAttributedString` with specified `Attribute`.
    func appendedAttribute(_ attribute: Attribute) -> NSAttributedString {
        return appendedAttributes([attribute])
    }

    /// Append attributes to string's substring and return an attributed string.
    ///
    /// - Parameters:
    ///   - attributes: An array contains `Attribtue`.
    ///   - substring: The substring.
    /// - Returns: `NSAttributedString` with specified `Attribute` on substring.
    func appendedAttributes(_ attributes: [Attribute], on substring: String) -> NSAttributedString {
        let range = NSString(string: string).range(of: substring)
        let mutableAttriString = mutableCopy() as! NSMutableAttributedString
        mutableAttriString.addAttributes(dictionary(from: attributes), range: range)
        return mutableAttriString
    }

    /// Append attribute on string's substring and return an attributed string.
    ///
    /// - Parameters:
    ///   - attribute: The `Attribute`
    ///   - substring: The substring.
    /// - Returns: `NSAttributedString` with specified `Attribute` on substring.
    func appendedAttribute(_ attribute: Attribute, on substring: String) -> NSAttributedString {
        return appendedAttributes([attribute], on: substring)
    }

    /// Returns the value for an attribute with a given name of the character at a given index, and by reference the range over which the attribute applies.
    ///
    /// - Parameters:
    ///   - attrName: AttributeName.
    ///   - location: The index for which to return attributes. This value must not exceed the bounds of the receiver.
    ///   - range: NSRangePointer can be nil if it's not necessary.
    /// - Returns: The `Attribute`.
    func findAttribute(_ attrName: AttributeName, at location: Int, effectiveRange range: NSRangePointer? = nil) -> Attribute? {
        if let attributeValue: Any = attribute(attrName, at: location, effectiveRange: range) {
            return Attribute(name: attrName, value: attributeValue)
        }
        return nil
    }
}
