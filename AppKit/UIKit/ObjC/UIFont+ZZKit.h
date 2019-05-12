//
//  UIFont+ZZKit.h
//  ZZKit
//
//  Created by Walker Stark on 1/14/18.
//  Copyright © 2018 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (ZZKit)

/**
 * Return a font object with allowing dynamic text capabilities for system font.
 * Dynamic text capabilities were added to automatically adjust text size based on user's text size setting.
 */
+ (UIFont *)zzk_systemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)zzk_boldSystemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)zzk_italicSystemFontOfSize:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
