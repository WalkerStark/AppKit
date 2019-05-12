//
//  String+Utils.swift
//  PDAppKit
//
//  Created by Walker Stark on 2018/9/20.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import Foundation

/// let string = "0123456789"
/// string[1...3] //=> "123"
/// string[3..<7] //=> "3456"
/// string[...4]  //=> "01234
/// string[..<4]  //=> "0123"
/// string[4...]  //=> "456789"
public extension String {
    
    subscript (idx: Int) -> Character {
        return self[index(startIndex, offsetBy: idx)]
    }
    
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
    
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
}

// MARK: - Validation
public extension String {
    
    var isBlank: Bool { return trimmingCharacters(in: .whitespaces).isEmpty }
    
    var first: String { return String(prefix(1)) }
    var last: String { return String(suffix(1)) }
    
    var toNSNumber: NSNumber? {
        if let number = Int(self) {
            return NSNumber(value: number)
        } else {
            return nil
        }
    }
}

// MARK: - Url Encoding String Percent Encoding
public extension String {
    var escaped: String {
        guard let result = String(describing: self).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return self }
        return result
    }
}

// MARK: - substring ranges

public extension String {

    func ranges(of searchString: String, options mask: NSString.CompareOptions = [], locale: Locale? = nil) -> [Range<String.Index>] {
        var ranges: [Range<String.Index>] = []
        while let range = range(of: searchString, options: mask, range: (ranges.last?.upperBound ?? startIndex)..<endIndex, locale: locale) {
            ranges.append(range)
        }
        return ranges
    }

    func nsRange(from range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }

    func nsRanges(of searchString: String, options mask: NSString.CompareOptions = [], locale: Locale? = nil) -> [NSRange] {
        let ranges = self.ranges(of: searchString, options: mask, locale: locale)
        return ranges.map { nsRange(from: $0) }
    }
}
