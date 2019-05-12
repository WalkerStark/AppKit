//
//  NSNumber+ZZFoundation.m
//  ZZFoundation
//
//  Created by Walker Stark on 10/24/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "NSNumber+ZZFoundation.h"

@implementation NSNumber (ZZFoundation)

+ (NSNumberFormatter *)zz_sharedNumberFormatter
{
    static NSNumberFormatter *_zz_sharedDateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _zz_sharedDateFormatter = [NSNumberFormatter new];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:NSCurrentLocaleDidChangeNotification
                                                          object:nil
                                                           queue:NSOperationQueue.currentQueue
                                                      usingBlock:^(NSNotification * _Nonnull note) {
                                                          [_zz_sharedDateFormatter setLocale:NSLocale.autoupdatingCurrentLocale];
                                                      }];
    });
    return _zz_sharedDateFormatter;
}

- (NSString *)zz_stringWithNumberStyle:(NSNumberFormatterStyle)numberStyle maxFractionDigits:(NSUInteger)maxDigits
{
    self.class.zz_sharedNumberFormatter.numberStyle = numberStyle;
    self.class.zz_sharedNumberFormatter.minimumFractionDigits = 0;
    self.class.zz_sharedNumberFormatter.maximumFractionDigits = maxDigits;
    self.class.zz_sharedNumberFormatter.roundingMode = NSNumberFormatterRoundHalfUp;
    return [self.class.zz_sharedNumberFormatter stringFromNumber:self];
}

#pragma mark - Decimal
#pragma mark -
- (NSString *)zz_wholeString
{
    return [self zz_stringWithNumberStyle:NSNumberFormatterDecimalStyle maxFractionDigits:0];
}

- (NSString *)zz_shortString
{
    return [self zz_stringWithNumberStyle:NSNumberFormatterDecimalStyle maxFractionDigits:1];
}

- (NSString *)zz_mediumString
{
    return [self zz_stringWithNumberStyle:NSNumberFormatterDecimalStyle maxFractionDigits:2];
}

- (NSString *)zz_longString
{
    return [self zz_stringWithNumberStyle:NSNumberFormatterDecimalStyle maxFractionDigits:3];
}

#pragma mark - Currency
#pragma mark -
- (NSString *)zz_wholeCurrencyString
{
    return [self zz_stringWithNumberStyle:NSNumberFormatterCurrencyStyle maxFractionDigits:0];
}

- (NSString *)zz_shortCurrencyString
{
    return [self zz_stringWithNumberStyle:NSNumberFormatterCurrencyStyle maxFractionDigits:1];
}

- (NSString *)zz_mediumCurrencyString
{
    return [self zz_stringWithNumberStyle:NSNumberFormatterCurrencyStyle maxFractionDigits:2];
}

- (NSString *)zz_longCurrencyString
{
    return [self zz_stringWithNumberStyle:NSNumberFormatterCurrencyStyle maxFractionDigits:3];
}

@end
