//
//  NibLoadableView.swift
//  PDAppKit
//
//  Created by roy.cao on 2019/1/12.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import UIKit

// MARK: - A protocol for defining how a view is loaded from a nib file.
public protocol NibLoadableView: AnyObject {

    static var nibName: String { get }

    static var nibBundle: Bundle { get }
}

// MARK: - NibLoadableView Default Implementation
public extension NibLoadableView {

    static var nibName: String { return String(describing: self) }

    static var nibBundle: Bundle { return Bundle.main }

    static var nib: UINib { return UINib(nibName: nibName, bundle: nibBundle) }
}

public extension NibLoadableView where Self: UIView {

    /// Loads a view from a nib file.
    ///
    /// - Parameters:
    ///   - nibName: A `String` representing the name of the nib file.
    ///   - nibBundle: A `Bundle` representing the location of the file.
    /// - Returns: A `UIView` representing the view loaded from the nib file.
    static func instantiate(nibName: String = Self.nibName, nibBundle: Bundle = Self.nibBundle) -> Self {
        let array = nibBundle.loadNibNamed(nibName, owner: nil, options: nil)
        guard let view = array?.first as? Self else {
            fatalError("Nib file for class does not exist!")
        }
        return view
    }
}
