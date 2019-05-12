//
//  ResuableView.swift
//  PDAppKit
//
//  Created by roy.cao on 2019/1/12.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import UIKit

// MARK: - A protocol for defining resusable or different subclasses of `UIView`.
public protocol ReusableView {

    static var reuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {

    static var reuseIdentifier: String { return String(describing: self) }
}

extension UITableViewCell: ReusableView { }

extension UICollectionReusableView: ReusableView {}

extension UITableViewHeaderFooterView: ReusableView { }
