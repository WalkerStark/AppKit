//
//  NumberFormatter+Utils.swift
//  PDFoundation
//
//  Created by Frank Huang on 2018/12/12.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import Foundation

public enum FractionDigits: Int {

    case zero = 0
    case short = 1
    case medium = 2
    case long = 3
}

public extension NumberFormatter {

    static let chinaLocale = "zh_CN"
    private static let shared = NumberFormatter()

    /// To know whether the currency symbol is left aligned.
    ///
    /// - Returns: The Bool value
    var isCurrencySymbolLeftAligned: Bool {
        guard let aString = self.string(from: NSNumber(value: 1)) else {
            return false
        }
        return aString[..<self.currencySymbol.count].isEmpty == false
    }

    /// Custom number to string formatter.
    ///
    /// - Parameters:
    ///   - number: The original number
    ///   - style: The custom number formatter style
    ///   - locale: The custom local
    ///   - fractionDigits: The custom FractionDigits
    /// - Returns: The optional formatted number string
    static func string(number: NSNumber,
                       style: NumberFormatter.Style,
                       locale: String = NumberFormatter.chinaLocale,
                       fractionDigits: FractionDigits = .medium) -> String? {
        let numberFormatter = NumberFormatter.shared
        numberFormatter.numberStyle = style
        numberFormatter.locale = Locale(identifier: locale)
        numberFormatter.minimumFractionDigits = fractionDigits.rawValue
        numberFormatter.maximumFractionDigits = fractionDigits.rawValue
        return numberFormatter.string(from: number)
    }

    /// Custom string to number formatter.
    ///
    /// - Parameters:
    ///   - string: The original number string
    ///   - style: The custom number formatter style
    ///   - locale: The custom local
    ///   - fractionDigits: The custom FractionDigits
    /// - Returns: The optional formatted number
    static func number(string: String,
                       style: NumberFormatter.Style,
                       locale: String = NumberFormatter.chinaLocale,
                       fractionDigits: FractionDigits = .medium) -> NSNumber? {
        let numberFormatter = NumberFormatter.shared
        numberFormatter.numberStyle = style
        numberFormatter.locale = Locale(identifier: locale)
        numberFormatter.minimumFractionDigits = fractionDigits.rawValue
        numberFormatter.maximumFractionDigits = fractionDigits.rawValue
        return numberFormatter.number(from: string)
    }

    /// Get currency number directly. The default fraction digits is 2.
    ///
    /// - Parameter string: The currency string
    /// - Returns: The optional currency number
    static func currencyNumber(string: String) -> NSNumber? {
        return number(string: string, style: .currency)
    }

    /// Get decimal number directly. The default fraction digits is 2.
    ///
    /// - Parameter string: The decimal string
    /// - Returns: The optional decimal number
    static func decimalNumber(string: String) -> NSNumber? {
        return number(string: string, style: .decimal)
    }

    /// Get currency string directly. The default fraction digits is 2.
    ///
    /// - Parameter number: The currency number
    /// - Returns: The optional currency string
    static func currencyString(number: NSNumber) -> String? {
        return string(number: number, style: .currency)
    }

    /// Get decimal string directly. The default fraction digits is 2.
    ///
    /// - Parameter number: The decimal number
    /// - Returns: The optional decimal string
    static func decimalString(number: NSNumber) -> String? {
        return string(number: number, style: .decimal)
    }
}
