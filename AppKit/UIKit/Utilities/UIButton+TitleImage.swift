//
//  UIButton+TitleImage.swift
//  PDAppKit
//
//  Created by Walker Stark on 2019/5/5.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import UIKit

public extension UIButton {
    
    var leadingTitle: String? {
        get {
            return currentTitle
        }
        
        set {
            if newValue != nil {
                let spacing: CGFloat = 4.0
                titleEdgeInsets = .init(top: 0, left: spacing, bottom: 0, right: -spacing)
                transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                titleLabel?.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)
                imageView?.transform = CGAffineTransform(rotationAngle: -CGFloat.pi)
            } else {
                titleEdgeInsets = .zero
            }
            
            setTitle(newValue, for: .normal)
            sizeToFit()
        }
    }
}
