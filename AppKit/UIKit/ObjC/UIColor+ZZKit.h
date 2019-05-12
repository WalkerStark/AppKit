//
//  UIColor+ZZKit.h
//  ZZKit
//
//  Created by Walker Stark on 1/14/18.
//  Copyright © 2018 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

NS_INLINE UIColor *ZZKColorWithARGB(CGFloat a, CGFloat r, CGFloat g, CGFloat b) {
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/255.0];
}

@interface UIColor (ZZKit)

/**
 * Given a hexadecimal color string, returns a alpha color with alpha, red, green, and blue components matching the passed in string.
 * The typical hex color string format is 0xAARRGGBB/0xRRGGBB/0xARGB/0xAB, with each digit being hexadecimal. Omit '#' and '0x' prefix. It supports below cases.
 *  Examples:
 *      0xFFFFFFFF/0xFFFFFF -> fully opaque white
 *      0xABCD -> same as 0xAABBCCDD
 *      0xAB -> same as 0xABABABAB
 * @param hexString The string of hexadecimal color with alpha channel.
 * @return A color object matching the specified hexadecimal color string. Null if the passed in string was not a valid hex color string.
 */
+ (UIColor *)zzk_colorWithHexString:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
