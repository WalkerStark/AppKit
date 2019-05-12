//
//  Array.swift
//  PDAppKit
//
//  Created by roy.cao on 2018/10/17.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import Foundation

/// var array = ["foo", "bar"]
/// array.remove(element: "foo")
/// array //=> ["bar"]
public extension Array where Element: Equatable {

    @discardableResult
    mutating func remove(_ element: Element) -> Index? {
        guard let index = firstIndex(of: element) else { return nil }
        remove(at: index)

        return index
    }

    @discardableResult
    mutating func remove(_ elements: [Element]) -> [Index] {
        return elements.compactMap { remove($0) }
    }
}

/// var array = [1, 2, 3, 3, 2, 1, 4]
/// array.unify() // [1, 2, 3, 4]
public extension Array where Element: Hashable {

    mutating func unify() {
        self = unified()
    }

    func unified() -> [Element] {
        return reduce(into: []) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }
}

/// let array = [0, 1, 2]
/// if let item = array[safe: 5] {
///     print("unreachable")
/// }
public extension Array {

    subscript(safe index: Index) -> Element? {
        return startIndex <= index && index < endIndex ? self[index] : nil
    }
}

public extension Array where Element == String {

    /// var array = ["A", "b", "c", "DE", "fG", 1]
    /// array.allLowercased() // ["a", "b", "c", "de", "fg", 1]
    mutating func allLowercase() {
        self = allLowercased()
    }

    /// Lowercased all data.
    ///
    /// - Returns: An array contains all lowercased string
    func allLowercased() -> [Element] {
        return map({ $0.lowercased() })
    }

    /// var array = ["A", "b", "c", "DE", "fG", 1]
    /// array.allLowercased() // ["A", "B", "C", "DE", "FG", 1]
    mutating func allUppercase() {
        self = allUppercased()
    }

    /// Uppercased all data.
    ///
    /// - Returns: An array contains all uppercased string
    func allUppercased() -> [Element] {
        return map({ $0.uppercased() })
    }
}
