//
//  Observer.swift
//  PDFoundation
//
//  Created by roy.cao on 2018/11/19.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import Foundation

class Observable<T>: ObservableType {
    
    internal private(set) var observers = Bag<(T, T) -> Void>()

    private let lock = SpinLock()
    
    public init() {  }

    public func subscribe(_ observer: @escaping (T, T) -> Void) -> Disposable {
        lock.lock(); defer { lock.unlock() }

        let token = observers.append(observer)

        return DisposableObserver { [weak self] in
            self?.removeItem(token)
        }
    }

    public func publish(newValue: T, oldValue: T) {
        lock.lock(); defer { lock.unlock() }

        for (_, observer) in observers {
            observer(newValue, oldValue)
        }
    }

    internal func removeItem(_ token: Token) {
        lock.lock(); defer { lock.unlock() }

        observers.removeValue(for: token)
    }
}
