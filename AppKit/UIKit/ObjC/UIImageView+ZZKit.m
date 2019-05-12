//
//  UIImageView+ZZKit.m
//  ZZKit
//
//  Created by Walker Stark on 1/22/18.
//  Copyright © 2018 Stark. All rights reserved.
//

#import "UIImageView+ZZKit.h"
#import "UIView+ZZKit.h"
#import "UIImage+ZZKit.h"

@implementation UIImageView (ZZKit)

- (void)zzk_setCornerRadius:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners borderWidth:(CGFloat)width borderColor:(UIColor *)color
{
    UIImage *image = self.image;
    image = (image.size.width == image.size.height) ? image : image.zzk_croppedImage;
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    
    CGSize cornerRadius = CGSizeMake(radius, radius);
    UIBezierPath *roundedPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadius];
    [roundedPath addClip];
    [image drawInRect:self.bounds];
    
    roundedPath.lineWidth = width;
    roundedPath.lineJoinStyle = kCGLineJoinRound;
    if (color) {
        [color setStroke];
        [roundedPath stroke];
    }
    [roundedPath closePath];

    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

@end
