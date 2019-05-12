//
//  Disposable.swift
//  PDFoundation
//
//  Created by roy.cao on 2018/11/19.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import Foundation

public protocol Disposable {

    func dispose()
}

extension Disposable {

    public func dispose(by bag: DisposeBag) {
        bag.append(self)
    }
}
