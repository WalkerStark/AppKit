//
//  UIImage+ZZKit.m
//  ZZKit
//
//  Created by Walker Stark on 1/14/18.
//  Copyright © 2018 Stark. All rights reserved.
//

#import "UIImage+ZZKit.h"
#import "ZZKitUtil.h"

@implementation UIImage (ZZKit)

+ (UIImage *)zzk_imageNamed:(NSString *)imageName
{
    return [self imageNamed:imageName inBundle:[NSBundle bundleForClass:ZZKitUtil.self] compatibleWithTraitCollection:nil];
}

+ (UIImage *)zzk_tintImage:(UIImage *)image tintColor:(UIColor *)tintColor
{
    UIImage *templateImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIGraphicsBeginImageContextWithOptions(templateImage.size, NO, templateImage.scale);
    [tintColor set];
    [templateImage drawInRect:CGRectMake(0, 0, templateImage.size.width, templateImage.size.height)];
    UIImage *tintImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintImage;
}

- (CGImagePropertyOrientation)zzk_exifImageOrientation
{
    CGImagePropertyOrientation propertyOrientation;
    switch (self.imageOrientation) {
        case UIImageOrientationUp:
            propertyOrientation = kCGImagePropertyOrientationUp;
            break;
        case UIImageOrientationDown:
            propertyOrientation = kCGImagePropertyOrientationDown;
            break;
        case UIImageOrientationLeft:
            propertyOrientation = kCGImagePropertyOrientationLeft;
            break;
        case UIImageOrientationRight:
            propertyOrientation = kCGImagePropertyOrientationRight;
            break;
        case UIImageOrientationUpMirrored:
            propertyOrientation = kCGImagePropertyOrientationUpMirrored;
            break;
        case UIImageOrientationDownMirrored:
            propertyOrientation = kCGImagePropertyOrientationDownMirrored;
            break;
        case UIImageOrientationLeftMirrored:
            propertyOrientation = kCGImagePropertyOrientationLeftMirrored;
            break;
        case UIImageOrientationRightMirrored:
            propertyOrientation = kCGImagePropertyOrientationRightMirrored;
            break;
    }
    return propertyOrientation;
}

- (UIImage *)zzk_originalImage
{
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (UIImage *)zzk_croppedImage
{
    CGFloat ratio;
    CGFloat width = self.size.width, height = self.size.height;
    CGRect cropRect = CGRectZero;
    
    if (width >= height) {
        ratio = height / width;
        cropRect = CGRectMake((width - height) / 2, 0, width * ratio, height);
    } else {
        ratio = width / height;
        cropRect = CGRectMake(0, (height - width) / 2, width, height * ratio);
    }
    
    CGImageRef croppedImageRef = CGImageCreateWithImageInRect(self.CGImage, cropRect);
    UIImage *croppedImage = [UIImage imageWithCGImage:croppedImageRef];
    CGImageRelease(croppedImageRef);
    return croppedImage;
}

- (UIImage *)zzk_antialiasingImage
{
    CGRect imageRect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, 0.0);
    [self drawInRect:CGRectInset(imageRect, 1, 1)];
    UIImage *antiImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return antiImage;
}

- (UIImage *)zzk_brightenWithAlpha:(CGFloat)alpha
{
    UIGraphicsBeginImageContext(self.size);
    CGRect imageRect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawInRect:imageRect];
    
    // Brightness overlay
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:1.0 alpha:alpha].CGColor);
    CGContextAddRect(context, imageRect);
    CGContextFillPath(context);
    
    UIImage* resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}

@end
