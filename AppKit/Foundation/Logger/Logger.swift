//
//  Logger.swift
//  PDFoundation
//
//  Created by Walker Stark on 2018/12/16.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import Foundation

private let logger = Logger()

@objc public class Logger: NSObject {

    public private(set) var appenders: [Appender] = [SystemAppender()]

    private let identifier: String
    private let loggerName: String

    @objc public init(identifier: String = Bundle.main.bundleID, loggerName: String = "Default") {
        self.identifier = identifier
        self.loggerName = loggerName
    }

    public func addAppender(_ appender: Appender) {
        appenders.append(appender)
    }

    public func error(_ message: String, _ args: CVarArg...) {
        log(level: .error, message: message, args: args)
    }

    public func warning(_ message: String, _ args: CVarArg...) {
        log(level: .warning, message: message, args: args)
    }

    public func info(_ message: String, _ args: CVarArg...) {
        log(level: .info, message: message, args: args)
    }

    public func debug(_ message: String, _ args: CVarArg...) {
        #if DEBUG
        log(level: .debug, message: message, args: args)
        #endif
    }

    public func verbose(_ message: String, _ args: CVarArg...) {
        log(level: .verbose, message: message, args: args)
    }
}

public extension Logger {

    @objc static func error(_ message: String) {
        logger.log(level: .error, message: message)
    }

    @objc static func warning(_ message: String) {
        logger.log(level: .warning, message: message)
    }

    @objc static func info(_ message: String) {
        logger.log(level: .info, message: message)
    }

    @objc static func debug(_ message: String) {
        logger.log(level: .debug, message: message)
    }

    @objc static func verbose(_ message: String) {
        logger.log(level: .verbose, message: message)
    }
}

private extension Logger {

    func log(level: LogLevel, message: String, args: [CVarArg] = []) {
        let format = "\(level.description) \(loggerName): \(message)"
        let formatedMsg = format + args.map({ "\($0)" }).reduce("", +)
        let logEvent = LogEvent(identifier: identifier, level: level, message: formatedMsg, loggerName: loggerName)
        
        appenders.forEach({ $0.append(event: logEvent) })
    }
}
