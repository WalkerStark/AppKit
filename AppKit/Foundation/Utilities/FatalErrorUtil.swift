//
//  FatalErrorUtil.swift
//  PDFoundation
//
//  Created by canius.chu on 2019/1/11.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import Foundation

public struct FatalErrorUtil {

    public static var fatalErrorClosure: (String, StaticString, UInt) -> Never = defaultFatalErrorClosure

    private static let defaultFatalErrorClosure = { Swift.fatalError($0, file: $1, line: $2) }

    static func replaceFatalError(closure: @escaping (String, StaticString, UInt) -> Never) {
        fatalErrorClosure = closure
    }

    static func restoreFatalError() {
        fatalErrorClosure = defaultFatalErrorClosure
    }
}
