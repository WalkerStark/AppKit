//
//  ObservableType.swift
//  PDFoundation
//
//  Created by roy.cao on 2018/11/19.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import Foundation

public protocol ObservableType {
    associatedtype Element

    func subscribe(_ observer: @escaping (Element, Element) -> Void) -> Disposable
}
