//
//  DateFormatter+Utils.swift
//  PDFoundation
//
//  Created by Frank Huang on 2018/12/3.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import Foundation

public enum DateFormat: String {

    case shortTime = "HH:mm"
    case mediumTime = "HH:mm:ss"
    case longTime = "HH:mm:ss.SSS"
    case weekDate = "EEEE dd/MM/yy"
    case tinyDate = "yMMMd"
    case shortDate = "dd/MM/YY"
    case mediumDate = "yyyy-MM-dd"
    case mediumDateDotLongTime = "dd.MM.yyyy HH:mm:ss.SSS"
    case mediumDateShortTime = "yyyy-MM-dd HH:mm"
    case mediumDateMediumTime = "yyyy-MM-dd HH:mm:ss"
    case mediumDateLongTime = "yyyy-MM-dd HH:mm:ss:SSS"
    case mediumDateLongLongTime = "yyyy-MM-dd HH:mm:ss zzz"
    case iso8601MediumDateMediumTime = "yyyy-MM-dd'T'HH:mm:ssZ"
    case iso8601MediumDateLongTime = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
}

public extension DateFormatter {

    static let chinaLocale = "zh_CN"
    private static let shared = DateFormatter()

    static var iso8601: DateFormatter = {
        let dateFormatter = DateFormatter.shared
        dateFormatter.dateFormat = DateFormat.iso8601MediumDateLongTime.rawValue
        dateFormatter.timeZone = TimeZone.utc
        dateFormatter.locale = Locale(identifier: DateFormatter.chinaLocale)
        return dateFormatter
    }()

    /// Return a custom formatted date string.
    ///
    /// - Parameters:
    ///   - date: The original date
    ///   - format: The custom format
    ///   - timeZone: The custom timezone
    ///   - locale: The custom locale
    /// - Returns: A formatted date string
    static func string(date: Date,
                       format: DateFormat = .iso8601MediumDateLongTime,
                       timeZone: TimeZone = TimeZone.utc,
                       locale: String = DateFormatter.chinaLocale) -> String {
        let dateFormatter = DateFormatter.shared
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = Locale(identifier: locale)
        return dateFormatter.string(from: date)
    }

    /// Return a system formatted date string.
    ///
    /// - Parameters:
    ///   - date: The original date
    ///   - dateStyle: The custom date style
    ///   - timeStyle: The custom time style
    ///   - timeZone: The custom timezone
    ///   - locale: The custom locale
    /// - Returns: A formatted date string
    static func string(date: Date,
                       dateStyle: DateFormatter.Style,
                       timeStyle: DateFormatter.Style,
                       timeZone: TimeZone = TimeZone.utc,
                       locale: String = DateFormatter.chinaLocale) -> String {
        let dateFormatter = DateFormatter.shared
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = Locale(identifier: locale)
        return dateFormatter.string(from: date)
    }

    /// Return a custom formatted date.
    ///
    /// - Parameters:
    ///   - string: The original date string
    ///   - format: The custom format
    ///   - timeZone: The custom timezone
    ///   - locale: The custom locale
    /// - Returns: An optional formatted date
    static func date(string: String,
                     format: DateFormat = .iso8601MediumDateLongTime,
                     timeZone: TimeZone = TimeZone.utc,
                     locale: String = DateFormatter.chinaLocale) -> Date? {
        let dateFormatter = DateFormatter.shared
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = Locale(identifier: locale)
        return dateFormatter.date(from: string)
    }

    /// Return a system formatted date.
    ///
    /// - Parameters:
    ///   - string: The original date string
    ///   - dateStyle: The custom date style
    ///   - timeStyle: The custom time style
    ///   - timeZone: The custom timezone
    ///   - locale: The custom locale
    /// - Returns: An optional formatted date
    static func date(string: String,
                     dateStyle: DateFormatter.Style,
                     timeStyle: DateFormatter.Style,
                     timeZone: TimeZone = TimeZone.utc,
                     locale: String = DateFormatter.chinaLocale) -> Date? {
        let dateFormatter = DateFormatter.shared
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = Locale(identifier: locale)
        return dateFormatter.date(from: string)
    }
}
