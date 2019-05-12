//
//  NSNumber+ZZFoundation.h
//  ZZFoundation
//
//  Created by Walker Stark on 10/24/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (ZZFoundation)

/**
 * Format a number to string with decimal style. Round number half up.
 */
@property (nonatomic, copy, readonly) NSString *zz_wholeString;             // 0 digits
@property (nonatomic, copy, readonly) NSString *zz_shortString;             // 1 digit
@property (nonatomic, copy, readonly) NSString *zz_mediumString;            // 2 digits
@property (nonatomic, copy, readonly) NSString *zz_longString;              // 3 digits

/**
 * Format a number to string with currency style. Round number half up.
 */
@property (nonatomic, copy, readonly) NSString *zz_wholeCurrencyString;     // 0 digits
@property (nonatomic, copy, readonly) NSString *zz_shortCurrencyString;     // 1 digit
@property (nonatomic, copy, readonly) NSString *zz_mediumCurrencyString;    // 2 digits
@property (nonatomic, copy, readonly) NSString *zz_longCurrencyString;      // 3 digits

@end

NS_ASSUME_NONNULL_END
