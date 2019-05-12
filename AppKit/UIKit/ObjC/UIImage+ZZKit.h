//
//  UIImage+ZZKit.h
//  ZZKit
//
//  Created by Walker Stark on 1/14/18.
//  Copyright © 2018 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>
@import ImageIO;

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZZKit)

/**
 * Returns the image object associated with the specified filename in ZZKit bundle.
 */
+ (UIImage *)zzk_imageNamed:(NSString *)imageName;

/**
 * Create a tint image from one image with tint color.
 */
+ (UIImage *)zzk_tintImage:(UIImage *)image tintColor:(UIColor *)tintColor;


@property (nonatomic, readonly) CGImagePropertyOrientation zzk_exifImageOrientation;

@property (nonatomic, readonly) UIImage *zzk_originalImage;
@property (nonatomic, readonly) UIImage *zzk_croppedImage;      // Resize and crop in center
@property (nonatomic, readonly) UIImage *zzk_antialiasingImage; // Similar with layer.allowsEdgeAntialiasing = YES

- (UIImage *)zzk_brightenWithAlpha:(CGFloat)alpha;  // Value range (0, 1)

@end

NS_ASSUME_NONNULL_END
