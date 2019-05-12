//
//  TimeZone+Utils.swift
//  PDFoundation
//
//  Created by Frank Huang on 2018/12/12.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import Foundation

public extension TimeZone {

    private enum DateTimeZone: Int {
        case utc = 0
        case gmt8 = 28800
    }

    static var utc: TimeZone = {
        TimeZone(secondsFromGMT: DateTimeZone.utc.rawValue) ?? TimeZone.current
    }()

    static var gmt8: TimeZone = {
        TimeZone(secondsFromGMT: DateTimeZone.gmt8.rawValue) ?? TimeZone.current
    }()
}
