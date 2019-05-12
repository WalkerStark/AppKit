//
//  NSString+ZZFoundation.h
//  ZZFoundation
//
//  Created by Walker Stark on 10/23/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_INLINE BOOL ZZStringIsEmpty(NSString *string) {
    return ([string stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet].length == 0);
}

@interface NSString (ZZFoundation)

@property (nonatomic, copy, readonly) NSString *zz_MD5String;
@property (nonatomic, copy, readonly) NSString *zz_SHA1String;

@property (nonatomic, copy, readonly) NSString *zz_quotedString;

@property (nonatomic, assign, readonly) BOOL zz_isValidEmail;
@property (nonatomic, assign, readonly) BOOL zz_isValidPhone;
@property (nonatomic, assign, readonly) BOOL zz_isValidDate;
@property (nonatomic, assign, readonly) BOOL zz_isValidURL;

@end

NS_ASSUME_NONNULL_END
