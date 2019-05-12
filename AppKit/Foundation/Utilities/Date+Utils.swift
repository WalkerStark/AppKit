//
//  Date+Utils.swift
//  PDFoundation
//
//  Created by Frank Huang on 2018/11/1.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import Foundation

public extension Calendar {

    static var utc: Calendar = {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.utc
        return calendar
    }()

    static var utcGregorian: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone.gmt8
        return calendar
    }()
}

public extension Date {

    private enum GregorianWeekDay: Int {
        case sunday = 1, monday, tuesday, wednesday, thrusday, friday, saturday
    }

    /// Determine whether self date is between since and until date.
    ///
    /// - Parameters:
    ///   - begin: The begin date
    ///   - end: The end date
    /// - Returns: The Bool value whether it is between two dates
    func isBetween(begin: Date, end: Date) -> Bool {
        return self >= begin && self <= end
    }

    /// Determine whether it is the weekend.
    ///
    /// - Parameter calendar: The current calendar
    /// - Returns: The Bool value whether it is the weekend
    func isWeekend(calendar: Calendar = Calendar.current) -> Bool {
        return calendar.isDateInWeekend(self)
    }

    /// Determine whether self date is equal to another date.
    ///
    /// - Parameters:
    ///   - date: The date for comparing
    ///   - calendar: The current calendar
    /// - Returns: The Bool value whether it is same day
    func isSameDay(with date: Date, calendar: Calendar = Calendar.current) -> Bool {
        return calendar.compare(self, to: date, toGranularity: .day) == ComparisonResult.orderedSame
    }

    /// Return the bool value if lhs earlier than rhs.
    ///
    /// - Parameters:
    ///   - lhs: Comparing date1
    ///   - rhs: Comparing date2
    /// - Returns: The bool value
    static func <= (lhs: Date, rhs: Date) -> Bool {
        return lhs.timeIntervalSince1970 <= rhs.timeIntervalSince1970
    }

    /// Return the bool value if lhs later than rhs.
    ///
    /// - Parameters:
    ///   - lhs: Comparing date1
    ///   - rhs: Comparing date2
    /// - Returns: The bool value
    static func >= (lhs: Date, rhs: Date) -> Bool {
        return lhs.timeIntervalSince1970 >= rhs.timeIntervalSince1970
    }

    /// Calculate next work day.
    ///
    /// - Parameter calendar: The current calendar
    /// - Returns: The next work date
    func gregorianNextWorkDayDate(calendar: Calendar = Calendar.current) -> Date {
        if isWeekend(calendar: calendar) {
            let weekDay = GregorianWeekDay(rawValue: calendar.component(.weekday, from: self))!
            let daysToSum: Int
            if weekDay == .saturday {
                daysToSum = 2
            } else {
                daysToSum = 1
            }
            return calendar.date(byAdding: .day, value: daysToSum, to: self)!
        } else {
            return self
        }
    }

    /// Calculate how many days between two dates.
    ///
    /// - Parameters:
    ///   - start: The start date
    ///   - end: The end date
    ///   - calendar: The current calendar
    /// - Returns: The amount of how many days
    static func daysBetweenDates(start: Date, end: Date, calendar: Calendar = Calendar.current) -> Int {
        return calendar.dateComponents([.day], from: start, to: end).day!
    }

    /// Calculate the latest work date by adding custom hours.
    ///
    /// - Parameters:
    ///   - date: The start date
    ///   - hours: The custom hours of one day
    ///   - calendar: The current calendar
    /// - Returns: The latest work date
    static func sumWorkDays(toDate date: Date, withHours hours: Int, calendar: Calendar = Calendar.current) -> Date {
        var date = date
        var hours = hours
        while hours > 0 {
            if hours >= 24 {
                date = calendar.date(byAdding: .day, value: 1, to: date)!
                date = date.gregorianNextWorkDayDate()
                hours -= 24
            } else {
                date = calendar.date(byAdding: .hour, value: hours, to: date)!
                date = date.gregorianNextWorkDayDate()
                hours -= hours
            }
        }
        return date
    }
}
