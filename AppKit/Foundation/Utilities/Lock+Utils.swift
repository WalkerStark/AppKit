//
//  Lock+Utils.swift
//  PDFoundation
//
//  Created by roy.cao on 2019/1/14.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import Foundation

public class SpinLock {

    private var unfairLock = os_unfair_lock_s()

    public init() { }

    func lock() {
        os_unfair_lock_lock(&unfairLock)
    }

    func unlock() {
        os_unfair_lock_unlock(&unfairLock)
    }
}
