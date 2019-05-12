//
//  ThemeProtocol.swift
//  PDAppKit
//
//  Created by Walker Stark on 2019/1/6.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import UIKit

public protocol ThemeProtocol {
    
    init(type: ThemeType)
    
    var type: ThemeType { get }
    var statusBarStyle: UIStatusBarStyle { get }

    func configureTabBarStyle()
    func configureNavigationBarStyle()
}

extension ThemeProtocol {

    func configureTextColorStyle() {
        UITextField.appearance().textTintColor = R.colors.dark
    }
}
