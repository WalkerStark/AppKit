//
//  UIView+ContentPriority.swift
//  PDAppKit
//
//  Created by ryan.fan on 2019/3/7.
//  Copyright © 2019 Farfetch. All rights reserved.
//

// MARK: - Configure constraints
extension UIView {

    public func constraintsEqualWithSuperview() {
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[self]|", options: [], metrics: nil, views: ["self": self]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[self]|", options: [], metrics: nil, views: ["self": self]))
    }

    public func constraintsMarginWithSuperviewBy(insets: UIEdgeInsets) {
        NSLayoutConstraint
            .activate(NSLayoutConstraint
                .constraints(withVisualFormat: "H:|-left-[self]-right-|",
                             options: [],
                             metrics: ["left": insets.left, "right": insets.right],
                             views: ["self": self]))
        NSLayoutConstraint
            .activate(NSLayoutConstraint
                .constraints(withVisualFormat: "V:|-top-[self]-bottom-|",
                             options: [],
                             metrics: ["top": insets.top, "bottom": insets.bottom],
                             views: ["self": self]))
    }

    public func constraintsMarginWithSuperviewBy(length: CGFloat) {
        constraintsMarginWithSuperviewBy(insets: UIEdgeInsets(top: length, left: length, bottom: length, right: length))
    }

    public func constraintsMarginWithSupervieLayoutMargin() {
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[self]-|", options: [], metrics: nil, views: ["self": self]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[self]-|", options: [], metrics: nil, views: ["self": self]))
    }

    public func constraintsCenterInSuperview() {
        constraintsCenterXInSuperview()
        constraintsCenterYInSuperview()
    }

    public func constraintsCenterXInSuperview() {
        let leadingGuide = UILayoutGuide()
        let trailingGuide = UILayoutGuide()

        superview?.addLayoutGuide(leadingGuide)
        superview?.addLayoutGuide(trailingGuide)

        let views = ["self": self, "leading": leadingGuide, "trailing": trailingGuide]
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[leading][self][trailing(leading)]|", options: [], metrics: nil, views: views))
    }

    public func constraintsCenterYInSuperview() {
        let topGuide = UILayoutGuide()
        let bottomGuide = UILayoutGuide()

        superview?.addLayoutGuide(topGuide)
        superview?.addLayoutGuide(bottomGuide)

        let views = ["self": self, "top": topGuide, "bottom": bottomGuide]
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[top][self][bottom(top)]|", options: [], metrics: nil, views: views))
    }
}

// MARK: - Configure content priority
extension UIView {

    @objc public func setContentPriorityForAllAxis(_ priority: UILayoutPriority) {
        setContentPriorityForVertical(priority)
        setContentPriorityForHorizontal(priority)
    }

    @objc public func setContentPriorityForHorizontal(_ priority: UILayoutPriority) {
        setContentHuggingPriority(priority, for: .horizontal)
        setContentCompressionResistancePriority(priority, for: .horizontal)
    }

    @objc public func setContentPriorityForVertical(_ priority: UILayoutPriority) {
        setContentHuggingPriority(priority, for: .vertical)
        setContentCompressionResistancePriority(priority, for: .vertical)
    }
}
