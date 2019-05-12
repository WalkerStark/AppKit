//
//  UIView+ZZKit.h
//  ZZKit
//
//  Created by Walker Stark on 1/14/18.
//  Copyright © 2018 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZFoundationUtil.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZZKit)

// Auto Layout
+ (instancetype)zzk_newAutoLayoutView;
- (void)zzk_constraintEqualWithSuperView;
- (void)zzk_constraintCenterInSuperview;
- (void)zzk_constraintCenterXInSuperview;
- (void)zzk_constraintCenterYInSuperview;

// Add effect for view
- (void)zzk_addTopShadow;
- (void)zzk_removeTopShadow;
- (void)zzk_addTopBorder;
- (void)zzk_removeTopBorder;

- (void)zzk_addDimBackground;
- (void)zzk_removeDimBackground;

// Avoid off-screen rendered, must call below methods when view has been layouted.
// If use auto layout, need call #setNeedsLayout and #layoutIfNeeded method first.
- (void)zzk_setCornerRadius:(CGFloat)radius;  // Default UIRectCornerAllCorners and clear color
- (void)zzk_setCornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color;
- (void)zzk_setCornerRadius:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners;
- (void)zzk_setCornerRadius:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners borderWidth:(CGFloat)width borderColor:(UIColor *)color;

// Animations
+ (void)zzk_animateWithDefaultDuration:(ZZVoidBlockType)animations;
+ (void)zzk_animateWithDefaultDuration:(ZZVoidBlockType)animations completion:(__nullable ZZBoolBlockType)completion;
+ (void)zzk_animateSpringWithDefaultDuration:(ZZVoidBlockType)animations;
+ (void)zzk_animateSpringWithDefaultDuration:(ZZVoidBlockType)animations completion:(__nullable ZZBoolBlockType)completion;

- (void)zzk_animateSpringScale;
- (void)zzk_setAnimatedHidden:(BOOL)hidden completion:(__nullable ZZVoidBlockType)completion;

@end

NS_ASSUME_NONNULL_END
