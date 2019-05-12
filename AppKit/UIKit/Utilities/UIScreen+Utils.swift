//
//  UIScreen+Utils.swift
//  PDAppKit
//
//  Created by Walker Stark on 2019/4/12.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import Foundation

public extension UIScreen {
    
    @objc(ScreenSizeType)
    enum SizeType: Int {
        case small
        case medium
        case large
    }
    
    @objc var sizeType: SizeType {
        switch bounds.size.width {
        case 0...320: return .small
        case 321...375: return .medium
        default: return .large
        }
    }
}
