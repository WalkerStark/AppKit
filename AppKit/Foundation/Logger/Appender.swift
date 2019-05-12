//
//  Appender.swift
//  PDFoundation
//
//  Created by Walker Stark on 2019/2/19.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import Foundation

/// Appender are responsible for sending logs to heir destination.
public protocol Appender {

    func append(event: LogEvent)
}
