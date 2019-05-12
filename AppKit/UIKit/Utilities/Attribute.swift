//
//  Attribute.swift
//  PDAppKit
//
//  Created by Frank Huang on 2019/1/23.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import Foundation

public typealias AttributeName = NSAttributedString.Key
public typealias ParagraphStyle = NSParagraphStyle
public typealias UnderlineStyle = NSUnderlineStyle

public enum Attribute {

    case font(UIFont)
    case textColor(UIColor)
    case backgroundColor(UIColor)
    case kern(Double)
    case baselineOffset(Double)
    case paragraphStyle(ParagraphStyle)
    case underlineStyle(UnderlineStyle)
    case underlineColor(UIColor)
    case link(URL)
    case custom(String, Any)

    init(name: AttributeName, value: Any) {
        func validate<T>(_ val: Any) -> T {
            assert(val is T, "Attribute with name \(name.rawValue) must have a value of type \(T.self)")
            return val as! T
        }

        func validateDouble(_ val: Any) -> Double {
            assert(val is NSNumber, "Attribute with name \(name.rawValue) must have a value that is castable to NSNumber")
            return (val as! NSNumber).doubleValue
        }

        var attribute: Attribute!

        switch name {
        case .font: attribute = .font(validate(value))
        case .foregroundColor: attribute = .textColor(validate(value))
        case .backgroundColor: attribute = .backgroundColor(validate(value))
        case .kern: attribute = .kern(validateDouble(value))
        case .baselineOffset: attribute = .baselineOffset(validateDouble(value))
        case .paragraphStyle: attribute = .paragraphStyle(validate(value))
        case .underlineStyle: attribute = .underlineStyle(UnderlineStyle(rawValue: validate(value)))
        case .underlineColor: attribute = .underlineColor(validate(value))
        case .link: attribute = .link(validate(value))

        default:
            if attribute == nil {
                attribute = .custom(name.rawValue, value)
            }
        }

        self = attribute
    }

    public var keyName: AttributeName {
        var name: AttributeName!

        switch self {
        case .font: name = .font
        case .textColor: name = .foregroundColor
        case .backgroundColor: name = .backgroundColor
        case .kern: name = .kern
        case .baselineOffset: name = .baselineOffset
        case .paragraphStyle: name = .paragraphStyle
        case .underlineStyle: name = .underlineStyle
        case .underlineColor: name = .underlineColor
        case .link: name = .link
        case .custom(let attributeName, _) where name == nil:
            name = AttributeName(rawValue: attributeName)
        default: break
        }

        return name
    }

    public var value: Any {
        switch self {
        case .font(let font): return font
        case .textColor(let color): return color
        case .backgroundColor(let color): return color
        case .kern(let kern): return kern
        case .baselineOffset(let offset): return offset
        case .paragraphStyle(let style): return style
        case .underlineStyle(let style): return style
        case .underlineColor(let color): return color
        case .link(let url): return url
        case .custom(_, let value): return value
        }
    }

    public var foundationValue: Any {
        switch self {
        case .underlineStyle(let style): return style.rawValue
        default: return value
        }
    }
}
