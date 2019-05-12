//
//  LogEvent.swift
//  PDFoundation
//
//  Created by Walker Stark on 2019/2/19.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import Foundation

public struct LogEvent {

    public let identifier: String
    public let level: LogLevel
    public let message: String
    public let loggerName: String
    public let fileName: String = #file
    public let fileLine: Int = #line
    public let function: String = #function
    public let threadID: UInt64 = currentThreadID
    public let threadName: String = currentThreadName
    public let timestamp: TimeInterval = Date().timeIntervalSince1970

    public init(identifier: String = Bundle.main.bundleID, level: LogLevel = .debug, message: String, loggerName: String = "") {
        self.identifier = identifier
        self.level = level
        self.message = message
        self.loggerName = loggerName
    }
}

private extension LogEvent {

    static var currentThreadName: String {
        if Thread.isMainThread {
            return "main"
        } else {
            var threadName = Thread.current.name ?? ""
            
            if threadName.isEmpty {
                let queueNameBytes = __dispatch_queue_get_label(nil)
                if let queueName = String(validatingUTF8: queueNameBytes) {
                    threadName = queueName
                }
            }

            return threadName.isEmpty ? "\(Thread.current)" : threadName
        }
    }

    static var currentThreadID: UInt64 {
        var threadID: UInt64 = 0
        return pthread_threadid_np(nil, &threadID) != 0 ? UInt64(pthread_mach_thread_np(pthread_self())) : threadID
    }
}
