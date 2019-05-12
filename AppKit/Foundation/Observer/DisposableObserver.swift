//
//  DisposableObserver.swift
//  PDFoundation
//
//  Created by roy.cao on 2018/11/19.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import Foundation

internal typealias OnDispose = () -> Void

class DisposableObserver: Disposable {

    var onDispose: OnDispose?

    init(_ onDispose: @escaping OnDispose) {
        self.onDispose = onDispose
    }

    deinit {
        dispose()
    }

    func dispose() {
        onDispose?()
        onDispose = nil
    }
}
