//
//  UITabBarItem+Badge.swift
//  PDAppKit
//
//  Created by Walker Stark on 2019/4/28.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import UIKit

private var associationKeyBadgeImage: UInt8 = 0

public extension UITabBarItem {
    
    var badgeImage: UIImage? {
        get {
            return objc_getAssociatedObject(self, &associationKeyBadgeImage) as? UIImage
        }
        set {
            objc_setAssociatedObject(self, &associationKeyBadgeImage, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
