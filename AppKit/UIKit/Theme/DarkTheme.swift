//
//  DarkTheme.swift
//  PDAppKit
//
//  Created by Walker Stark on 2019/1/6.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import UIKit

class DarkTheme: ThemeProtocol {
    
    private var themeType: ThemeType
    
    required init(type: ThemeType) {
        themeType = type
    }
    
    var type: ThemeType { return themeType }
    
    var statusBarStyle: UIStatusBarStyle { return .lightContent }

    func configureTabBarStyle() {
        let tabBar = UITabBar.appearance()
        let tabBarItem = UITabBarItem.appearance(whenContainedInInstancesOf: [UITabBar.self])

        tabBar.isTranslucent = false
        tabBar.barTintColor = nil
        tabBar.tintColor = R.colors.white
        tabBar.unselectedItemTintColor = R.colors.grey
        tabBar.backgroundImage = UIImage(color: R.colors.dark)
        tabBar.shadowImage = UIImage(color: R.colors.dark)

        tabBarItem.setTitleTextAttributes([.foregroundColor: R.colors.grey], for: .normal)
        tabBarItem.setTitleTextAttributes([.foregroundColor: R.colors.white], for: .selected)
    }

    func configureNavigationBarStyle() {
        let navigationBar = UINavigationBar.appearance()
        let barButtonItem = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
        let backIndicatorImage = R.images.nav_bar_back

        navigationBar.isTranslucent = false
        navigationBar.barTintColor = nil
        navigationBar.tintColor = R.colors.white
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(color: R.colors.dark), for: .default)
        navigationBar.backIndicatorImage = backIndicatorImage.rightToLeftAdjusted
        navigationBar.backIndicatorTransitionMaskImage = backIndicatorImage.tinted(color: R.colors.white)
        navigationBar.titleTextAttributes = [.foregroundColor: R.colors.white]

        barButtonItem.setTitleTextAttributes([.foregroundColor: R.colors.white], for: .normal)
        barButtonItem.setTitleTextAttributes([.foregroundColor: R.colors.white], for: .highlighted)
        barButtonItem.setTitleTextAttributes([.foregroundColor: R.colors.lightGrey], for: .disabled)
    }
}
