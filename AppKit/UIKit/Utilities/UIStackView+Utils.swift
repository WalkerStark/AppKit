//
//  UIStackView+Utils.swift
//  PDAppKit
//
//  Created by Walker Stark on 2019/1/16.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import UIKit

public extension UIStackView {

    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach(addArrangedSubview)
    }

    func removeArrangedSubviews(_ views: [UIView]) {
        views.forEach(removeArrangedSubview)
    }

    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach(removeArrangedSubview)
    }
}
