//
//  LogLevel.swift
//  PDFoundation
//
//  Created by Walker Stark on 2019/2/19.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import Foundation

@objc public enum LogLevel: Int, CustomStringConvertible {

    case error = 1      // Error logs only
    case warning = 2    // Error and warning logs
    case info = 3       // Error, warning and info logs
    case debug = 4      // Error, warning, info and debug logs
    case verbose = 5    // Error, warning, info, debug and verbose logs

    /// Returns a human readable representation of the log level.
    public var description: String {
        switch self {
        case .error:
            return "❌ [Error]"
        case .warning:
            return "⚠️ [Warning]"
        case .info:
            return "ℹ️ [Info]"
        case .debug:
            return "🔨 [Debug]"
        case .verbose:
            return "☕ [Verbose]"
        }
    }
}
