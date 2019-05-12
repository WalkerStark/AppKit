//
//  UIImage.swift
//  PDAppKit
//
//  Created by roy.cao on 2018/10/17.
//  Copyright © 2018 Farfetch. All rights reserved.
//

import UIKit

public extension UIImage {

    convenience init(color: UIColor, rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1), borderColor: UIColor? = nil, borderWidth: CGFloat = 0.0) {
        UIGraphicsBeginImageContext(rect.size)
        defer { UIGraphicsEndImageContext() }

        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        if let borderColor = borderColor {
            var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0
            let isValid = borderColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

            if isValid {
                context?.setStrokeColor(red: red, green: green, blue: blue, alpha: alpha)
                context?.stroke(rect, width: borderWidth)
            }
        }

        if let image = UIGraphicsGetImageFromCurrentImageContext(), let cgImage = image.cgImage {
            self.init(cgImage: cgImage)
        } else {
            self.init()
        }
    }

    func tinted(color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }

        let context = UIGraphicsGetCurrentContext()
        let rect = CGRect(origin: CGPoint.zero, size: size)

        context?.setBlendMode(.sourceIn)
        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        draw(in: rect)

        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

public extension UIImage {

    // iOS 11 flips the back button automatically for right to left layout
    var rightToLeftAdjusted: UIImage {
        if #available(iOS 11, *) {
        } else if IS_RIGHT_TO_LEFT, let image = self.rotated(clockwise: CGFloat.pi) {
            return image
        }
        return self
    }

    func rotated(clockwise radians: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }

        let context = UIGraphicsGetCurrentContext()

        let originalRect = CGRect(origin: CGPoint.zero, size: self.size)
        let center = CGPoint(x: originalRect.midX, y: originalRect.midY)
        let transformedRect = CGRect(origin: CGPoint(x: -center.x, y: -center.y), size: originalRect.size)

        context?.translateBy(x: center.x, y: center.y)
        context?.rotate(by: radians)

        guard let cgImage = self.cgImage else { return nil }

        context?.draw(cgImage, in: transformedRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    func cropped(rect: CGRect) -> UIImage? {
        let originalRect = CGRect(
            x: rect.origin.x * scale,
            y: rect.origin.y * scale,
            width: rect.size.width * scale,
            height: rect.size.height * scale
        )

        guard let cgImage = cgImage, let imageRef = cgImage.cropping(to: originalRect) else { return nil }

        return UIImage(cgImage: imageRef, scale: scale, orientation: imageOrientation)
    }

    func resized(size: CGSize) -> UIImage? {
        guard let data = self.pngData(), let imageSource = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }

        let maxPixelSize = max(size.width, size.height)
        let options: [NSString: Any] = [
            kCGImageSourceThumbnailMaxPixelSize: maxPixelSize,
            kCGImageSourceCreateThumbnailFromImageAlways: true
        ]

        return CGImageSourceCreateImageAtIndex(imageSource, 0, options as CFDictionary).flatMap({ UIImage(cgImage: $0) })
    }
}

public extension UIImage {

    enum ScalingMode {
        case aspectFill
        case aspectFit

        func aspectRatio(between size: CGSize, and otherSize: CGSize) -> CGFloat {
            let aspectWidth  = size.width / otherSize.width
            let aspectHeight = size.height / otherSize.height

            switch self {
            case .aspectFill: return max(aspectWidth, aspectHeight)
            case .aspectFit: return min(aspectWidth, aspectHeight)
            }
        }
    }
}

public extension UIImage {

    var orientationAdjusted: UIImage {
        if self.imageOrientation == .up {
            return self
        }
        var transform = CGAffineTransform.identity

        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: .pi)

        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)

        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: -.pi / 2)

        default:
            break
        }

        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)

        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)

        default:
            break
        }

        guard let cgImage = cgImage, let space = cgImage.colorSpace else { return self }

        let ctx = CGContext(data: nil, width: Int(self.size.width),
                            height: Int(self.size.height),
                            bitsPerComponent: cgImage.bitsPerComponent,
                            bytesPerRow: 0,
                            space: space,
                            bitmapInfo: cgImage.bitmapInfo.rawValue)
        ctx?.concatenate(transform)

        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(cgImage, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(self.size.height), height: CGFloat(self.size.width)))
        default:
            ctx?.draw(cgImage, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(self.size.width), height: CGFloat(self.size.height)))
        }

        let cgimg: CGImage = (ctx?.makeImage())!
        let img = UIImage(cgImage: cgimg)

        return img
    }
}

public extension UIImage {

    func toJPEG(quality: CGFloat = 1.0) -> Data? {
        return self.jpegData(compressionQuality: quality)
    }

    func toPNG(quarity: CGFloat = 1.0) -> Data? {
        return self.pngData()
    }

    func compressedToData() -> Data? {
        guard var zipImageData = self.jpegData(compressionQuality: 1.0) else { return nil }

        let originalImgSize = zipImageData.count/1024 as Int

        if originalImgSize > 1500 {
            zipImageData = self.jpegData(compressionQuality: 0.2)!
        } else if originalImgSize > 600 {
            zipImageData = self.jpegData(compressionQuality: 0.4)!
        } else if originalImgSize > 400 {
            zipImageData = self.jpegData(compressionQuality: 0.6)!
        } else if originalImgSize > 300 {
            zipImageData = self.jpegData(compressionQuality: 0.7)!
        } else if originalImgSize > 200 {
            zipImageData = self.jpegData(compressionQuality: 0.8)!
        }
        return zipImageData
    }
}
