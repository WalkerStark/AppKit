//
//  ThemeManager.swift
//  PDAppKit
//
//  Created by Walker Stark on 2019/1/6.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import UIKit

public class ThemeManager {

    private static let shared = ThemeManager(theme: ThemeType.light.theme)

    private var theme: ThemeProtocol {
        didSet {
            updateTheme()
        }
    }

    private init(theme: ThemeProtocol) {
        self.theme = theme
        updateTheme()
    }

    private func updateTheme() {
        theme.configureTabBarStyle()
        theme.configureNavigationBarStyle()
        theme.configureTextColorStyle()
    }
}

extension ThemeManager {

    public static var currentTheme: ThemeProtocol {
        return shared.theme
    }

    public static func switchTheme(_ themeType: ThemeType) {
        shared.theme = themeType.theme
    }
}
