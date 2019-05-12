//
//  LightTheme.swift
//  PDAppKit
//
//  Created by Walker Stark on 2019/1/6.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import UIKit

class LightTheme: ThemeProtocol {
    
    private var themeType: ThemeType
    
    required init(type: ThemeType) {
        themeType = type
    }
    
    var type: ThemeType { return themeType }
    
    var statusBarStyle: UIStatusBarStyle { return .default }

    func configureTabBarStyle() {
        let tabBar = UITabBar.appearance()
        let tabBarItem = UITabBarItem.appearance(whenContainedInInstancesOf: [UITabBar.self])

        tabBar.isTranslucent = false
        tabBar.barTintColor = .white
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .darkGray
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage(color: .white)
        
        tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.darkGray], for: .normal)
        tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
    }

    func configureNavigationBarStyle() {
        let navigationBar = UINavigationBar.appearance()
        let barButtonItem = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
        let backIndicatorImage = R.images.nav_bar_back

        navigationBar.isTranslucent = false
        navigationBar.barTintColor = R.colors.white
        navigationBar.tintColor = R.colors.dark
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.backIndicatorImage = backIndicatorImage.rightToLeftAdjusted
        navigationBar.backIndicatorTransitionMaskImage = backIndicatorImage.rightToLeftAdjusted
        navigationBar.titleTextAttributes = [.foregroundColor: R.colors.dark]

        barButtonItem.setTitleTextAttributes([.foregroundColor: R.colors.dark], for: .normal)
        barButtonItem.setTitleTextAttributes([.foregroundColor: R.colors.dark], for: .highlighted)
        barButtonItem.setTitleTextAttributes([.foregroundColor: R.colors.grey], for: .disabled)
    }
}
