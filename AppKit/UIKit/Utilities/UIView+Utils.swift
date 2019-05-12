//
//  UIView+Utils.swift
//  PDAppKit
//
//  Created by Walker Stark on 2018/9/21.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import UIKit

public extension UIView {

    convenience init(autoLayout: Bool) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = !autoLayout
    }

    func add(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }

    func removeAllSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }

    @objc var opaqueBackgroundColor: UIColor? {
        get { return backgroundColor }
        set {
            isOpaque = true
            backgroundColor = newValue
        }
    }
}

extension UIView {

    public var firstResponder: UIView? {
        guard !isFirstResponder else { return self }

        for subview in subviews {
            if let firstResponder = subview.firstResponder {
                return firstResponder
            }
        }

        return nil
    }
}

// MARK: - Configuring a View’s Visual Appearance

extension UIView {

    /// Adds a customizable simple gradient layer to the view.
    /// - Parameters:
    ///   - type:   A `CAGradientLayerType` struct typed value. Possible values are `.axial`, `.conic`, and `.radial`.
    ///   - color:  A `UIColor` typed color upon whom the `CGColorRef` typed gradient stops are based.
    /// - Todo: To support `.conic` (iOS 12.0+) and `.radial` types (with more parameters) whenever necessary.
    @objc public func addGradientLayer(withType type: CAGradientLayerType = .axial, usingBaseColor color: UIColor = .white) {
        let gradientLayer = CAGradientLayer()
        if type == .axial { gradientLayer.colors = [color.withAlphaComponent(0.0).cgColor, color.withAlphaComponent(1.0).cgColor] }
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

// MARK: - Creating Constraints Using Layout Anchors

extension UIView {

    /// Gets a layout anchor representing the bottom edge (either of the view or of the default safe area) with a smaller y-coordinate.
    @objc public var bottomAnchorWithinDefaultSafeArea: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomAnchor
        }
    }

    /// Gets a layout anchor representing the top edge (either of the view or of the default safe area) with a bigger y-coordinate.
    @objc public var topAnchorWithinDefaultSafeArea: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topAnchor
        }
    }
}
