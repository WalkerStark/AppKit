//
//  SystemAppender.swift
//  PDFoundation
//
//  Created by Walker Stark on 2019/2/19.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import Foundation
import os.log

public class SystemAppender: Appender {

    private var cachedOSLog: [String: OSLog] = [:]

    public func append(event: LogEvent) {
        os_log("%{public}@", log: oslog(for: event), type: event.level.logType, event.message)
    }

    private func oslog(for event: LogEvent) -> OSLog {
        let key = event.identifier + event.loggerName

        if let oslog = cachedOSLog[key] {
            return oslog
        }

        let oslog = OSLog(subsystem: event.identifier, category: event.loggerName)
        cachedOSLog[key] = oslog

        return oslog
    }
}

private extension LogLevel {

    var logType: OSLogType {
        switch self {
        case .error: return .fault
        case .warning: return .error
        case .info: return .info
        case .debug, .verbose: return .debug
        }
    }
}
