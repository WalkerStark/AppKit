//
//  Optional+Utils.swift
//  PDAppKit
//
//  Created by Walker Stark on 2018/9/21.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {

    public var isNilOrBlank: Bool {
        return self?.isBlank ?? true
    }
}

extension Optional where Wrapped: Collection {

    public var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}
