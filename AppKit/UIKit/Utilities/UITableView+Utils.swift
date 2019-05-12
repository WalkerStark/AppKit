//
//  UITableView.swift
//  PDAppKit
//
//  Created by roy.cao on 2018/10/17.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import UIKit

// MARK: - UITableViewCell Registration
public extension UITableView {

    func register<T: UITableViewCell>(_ classType: T.Type) {
        register(classType, forCellReuseIdentifier: classType.reuseIdentifier)
    }

    func register<T: UITableViewCell>(_ classType: T.Type) where T: NibLoadableView {
        register(classType.nib, forCellReuseIdentifier: classType.reuseIdentifier)
    }
}

// MARK: - UITableViewCell Dequeue
public extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(_ classType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: classType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier \(T.reuseIdentifier)")
        }
        return cell
    }
}

// MARK: - UITableViewHeaderFooterView Registration
public extension UITableView {

    func register<T: UITableViewHeaderFooterView>(_ classType: T.Type) {
        register(classType, forHeaderFooterViewReuseIdentifier: classType.reuseIdentifier)
    }

    func register<T: UITableViewHeaderFooterView>(_ classType: T.Type) where T: NibLoadableView {
        register(classType.nib, forHeaderFooterViewReuseIdentifier: classType.reuseIdentifier)
    }
}
