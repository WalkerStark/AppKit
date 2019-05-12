//
//  Variable.swift
//  PDFoundation
//
//  Created by roy.cao on 2018/11/19.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import Foundation

public class Variable<T>: ObservableType {

    private let observable = Observable<T>()

    public var value: T {
        didSet {
            observable.publish(newValue: value, oldValue: oldValue)
        }
    }

    public init(_ value: T) {
        self.value = value
    }

    /// subscribe for new value only
    public func subscribe(_ observer: @escaping (T) -> Void) -> Disposable {
        return observable.subscribe({ (newValue, _) in
            observer(newValue)
        })
    }
    
    /// subscribe for new value (first one) and old value (second)
    public func subscribe(_ observer: @escaping (_ newVlaue: T, _ oldValue: T) -> Void) -> Disposable {
        return observable.subscribe(observer)
    }
}
