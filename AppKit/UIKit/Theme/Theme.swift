//
//  Theme.swift
//  PDAppKit
//
//  Created by Walker Stark on 2018/12/22.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import UIKit

public enum ThemeType {

    case light
    case dark

    var theme: ThemeProtocol {
        switch self {
        case .light: return LightTheme(type: self)
        case .dark: return DarkTheme(type: self)
        }
    }
}

extension UILabel {

    @objc dynamic public var textTintColor: UIColor {
        get { return textColor }
        set { textColor = textTintColor }
    }
}

extension UITextField {

    @objc dynamic public var textTintColor: UIColor? {
        get { return textColor }
        set { textColor = textTintColor }
    }
}
