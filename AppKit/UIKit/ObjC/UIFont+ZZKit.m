//
//  UIFont+ZZKit.m
//  ZZKit
//
//  Created by Walker Stark on 1/14/18.
//  Copyright © 2018 Stark. All rights reserved.
//

#import "UIFont+ZZKit.h"
@import CoreText;

static const CGFloat kMinimumFontSize = 8.0;
static const CGFloat kMaximumFontSize = 48.0;
const CGFloat kMaximumDynamicTextScale = 2.0;

@implementation UIFont (ZZKit)

+ (UIFont *)zzk_systemFontOfSize:(CGFloat)fontSize
{
    return [UIFont systemFontOfSize:[self dynamicFontSize:fontSize]];
}

+ (UIFont *)zzk_boldSystemFontOfSize:(CGFloat)fontSize
{
    return [UIFont boldSystemFontOfSize:[self dynamicFontSize:fontSize]];
}

+ (UIFont *)zzk_italicSystemFontOfSize:(CGFloat)fontSize
{
    return [UIFont italicSystemFontOfSize:[self dynamicFontSize:fontSize]];
}

/**
 * @warning Unfortunately Apple does not support dynamic text for custom fonts. So we develop our own support by deriving the user's text size setting as a scale factor relative to the normal/default text size.
 * The underlying assumption is that the default system font is 16pt San Francisco. Let's state this assumption and log errors (but not crash - Apple could change the system font in an iOS update) if it is not true
 */
+ (CGFloat)dynamicFontSize:(CGFloat)fontSize
{
    UIFont *currSystemFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    // Prevent ludicrously large dynamic text settings that render our app unusable
    CGFloat defaultRegularFontSize = UIFont.labelFontSize;
    CGFloat scale = MIN(currSystemFont.pointSize / defaultRegularFontSize, kMaximumDynamicTextScale);
    return MIN( MAX(fontSize * scale, kMinimumFontSize), kMaximumFontSize );
}

@end
