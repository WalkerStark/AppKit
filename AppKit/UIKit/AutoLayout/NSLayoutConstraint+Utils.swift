//
//  NSLayoutConstraint+Utils.swift
//  PDAppKit
//
//  Created by Walker Stark on 2019/3/6.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import Foundation

/// This method is a helper for making variable dictionaries for +constraintsWithVisualFormat:options:metrics:views:.
/// dictionaryOfVariableBindings(self, label, imageView, button) is equivalent to ["label": label, "imageView": imageView, "button": button].
///
/// - Parameters:
///   - object: A object which must hold all passed variables.
///   - variables: A va-list of variables for seting constraint, all variables must be the passed object's property.
/// - Returns: A variable dictionary which key's name is equal with variable's name.
public func dictionaryOfVariableBindings(_ object: NSObject, _ variables: NSObject...) -> [String: NSObject] {
    return _dictionaryOfVariableBindings(object, variables)
}

private func _dictionaryOfVariableBindings(_ object: NSObject, _ variables: [NSObject]) -> [String: NSObject] {
    var varDict = [String: NSObject]()
    var varCount: CUnsignedInt = 0

    guard let ivars = class_copyIvarList(object_getClass(object), &varCount) else { return [:] }

    variables.forEach({
        for idx in 0..<varCount {
            let ivar = ivars[Int(idx)]
            if let value = object_getIvar(object, ivar) as? NSObject, value == $0,
                let name = ivar_getName(ivar), let key = String(utf8String: name)?.split(separator: ".").first.flatMap({ String($0) }) {
                varDict[key] = $0
                break
            }
        }
    })

    return varDict
}

public extension NSLayoutConstraint {
    
    static func constraints(withVisualFormat format: String, options opts: NSLayoutConstraint.FormatOptions = [], views: [String: Any]) -> [NSLayoutConstraint] {
        return constraints(withVisualFormat: format, options: opts, metrics: nil, views: views)
    }
}
