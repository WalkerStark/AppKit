//
//  UIKitUtils.swift
//  PDAppKit
//
//  Created by Walker Stark on 2018/9/20.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import UIKit

public let IS_PAD = UIDevice.current.userInterfaceIdiom == .pad
public let IS_PHONE = UIDevice.current.userInterfaceIdiom == .phone
public var IS_PORTRAIT: Bool { return UIApplication.shared.statusBarOrientation.isPortrait }
public var IS_LANDSCAPE: Bool { return UIApplication.shared.statusBarOrientation.isLandscape }
public var IS_LEFT_TO_RIGHT: Bool { return UIApplication.shared.userInterfaceLayoutDirection == .leftToRight }
public var IS_RIGHT_TO_LEFT: Bool { return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft }

public extension Int {

    // Exclude max
    @inline(__always) static func random(min: Int = 0, max: Int = Int.max) -> Int {
        return Int(arc4random()) % (max - min) + min
    }
}

public extension CGFloat {

    // Exclude max
    @inline(__always) static func random(min: CGFloat = 0.0, max: CGFloat = 1.0) -> CGFloat {
        return (CGFloat(arc4random()) / CGFloat(UINT32_MAX)) * (max - min) + min
    }
}
