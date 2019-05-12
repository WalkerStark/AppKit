//
//  UIColor+ZZKit.m
//  ZZKit
//
//  Created by Walker Stark on 1/14/18.
//  Copyright © 2018 Stark. All rights reserved.
//

#import "UIColor+ZZKit.h"

@implementation UIColor (ZZKit)

+ (UIColor *)zzk_colorWithHexString:(NSString *)hexString
{
    NSCharacterSet *charactetSet = [NSCharacterSet characterSetWithCharactersInString:@"#"];
    hexString = [hexString stringByTrimmingCharactersInSet:charactetSet];
    NSString *hexPrefix = @"0x";
    if ([hexString hasPrefix:hexPrefix]) {
        hexString = [hexString stringByReplacingOccurrencesOfString:hexPrefix withString:@""];
    }
    
    if (hexString.length != 8) {
        if (hexString.length == 6) {
            hexString = [NSString stringWithFormat:@"FF%@", hexString];
        } else if (hexString.length == 4) {
            hexString = [NSString stringWithFormat:@"%c%c%c%c%c%c%c%c",
                         [hexString characterAtIndex:0], [hexString characterAtIndex:0], [hexString characterAtIndex:1], [hexString characterAtIndex:1],
                         [hexString characterAtIndex:2], [hexString characterAtIndex:2], [hexString characterAtIndex:3], [hexString characterAtIndex:3]];
        } else if (hexString.length == 2) {
            hexString = [[[hexString stringByAppendingString:hexString] stringByAppendingString:hexString] stringByAppendingString:hexString];
        }
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    unsigned hexInt; [scanner scanHexInt: &hexInt];
    return ZZKColorWithARGB((hexInt & 0xFF000000) >> 24, (hexInt & 0xFF0000) >> 16, (hexInt & 0xFF00) >> 8, (hexInt & 0xFF));
}

@end
