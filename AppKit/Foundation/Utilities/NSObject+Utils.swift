//
//  NSObject+Utils.swift
//  PDAppKit
//
//  Created by roy.cao on 2018/10/25.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import Foundation

public protocol ClassNameProtocol {

    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {

    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}

public extension NSObject {

    /// Check if is real objc object, not converted from swift object by `as` keyword.
    var isRealObjCObject: Bool {
        return !NSStringFromClass(type(of: self)).contains(".")
    }
    
    var dictionaryRepresentation: [String: Any] {
        var keyValuePair: [String: Any] = [:]
        
        func buildKeyValuePair(_ cls: AnyClass?) {
            guard let cls = cls else { return }
            
            var propertyCount: CUnsignedInt = 0
            let propertyList = class_copyPropertyList(cls, &propertyCount)
            defer { free(propertyList) }
            
            guard let properties = propertyList else { return }
            
            for idx in 0..<propertyCount {
                let property = properties[Int(idx)]
                let name = String(utf8String: property_getName(property))!
                var value: Any? = "<invalid>"
                let propertyTypeStr = property_copyAttributeValue(property, "T")
                
                if let propTypeStr = propertyTypeStr, strlen(propTypeStr) > 0 {
                    let propertyType = String(propTypeStr[0])
                    
                    switch propertyType {
                    case ":":   // selector
                        var getterSEL: Selector
                        let getterName = property_copyAttributeValue(property, "G")
                        if let gName = getterName {
                            getterSEL = sel_getUid(gName)
                        } else {
                            getterSEL = NSSelectorFromString(name)
                        }
                        free(getterName)
                        value = NSStringFromSelector(getterSEL)
                    case "v":
                        value = "<void>"
                    case "?":
                        value = "<undefined>"
                    default:
                        value = self.value(forKey: name)
                    }
                }
                
                free(propertyTypeStr)
                
                guard let objValue = value as? NSObject else { continue }

                if objValue is NSDictionary {
                    keyValuePair[name] = objValue
                } else {
                    keyValuePair[name] = "\(objValue)"
                }
            }
        }
        
        let clazz: AnyClass? = object_getClass(self)
        buildKeyValuePair(clazz)
        
        var superClazz: AnyClass?
        while superClazz != nil && superClazz != clazz {
            superClazz = class_getSuperclass(clazz)!
            buildKeyValuePair(superClazz)
        }
        
        return keyValuePair
    }
}
