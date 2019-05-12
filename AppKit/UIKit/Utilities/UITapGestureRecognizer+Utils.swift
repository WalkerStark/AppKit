//
//  UITapGestureRecognizer+Utils.swift
//  PDAppKit
//
//  Created by Mier.Mieraisan on 2019/2/15.
//  Copyright © 2019 Farfetch. All rights reserved.
//

import Foundation

public extension UITapGestureRecognizer {

    /// Determind wether tap gesture encounter in target range of UILabel
    ///
    /// - Parameters:
    ///   - label: Simple UILabel
    ///   - targetRange: link text existing NS Range
    /// - Returns: boolean value
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)

        let xCoordinate: CGFloat = (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x
        let yCoordinate: CGFloat = (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y
        let textContainerOffset = CGPoint(x: xCoordinate, y: yCoordinate)

        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }

}
