//
//  UIEdgeInsets+Utils.swift
//  PDAppKit
//
//  Created by Walker Stark on 2019/1/4.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import Foundation

extension UIEdgeInsets {

    public static func + (lhs: UIEdgeInsets, rhs: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: lhs.top+rhs.top, left: lhs.left+rhs.left, bottom: lhs.bottom+rhs.bottom, right: lhs.right+rhs.right)
    }

    public static func += (lhs: inout UIEdgeInsets, rhs: UIEdgeInsets) {
        lhs.top += rhs.top
        lhs.left += rhs.left
        lhs.bottom += rhs.bottom
        lhs.right += rhs.right
    }
}
