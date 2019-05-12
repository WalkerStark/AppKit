//
//  NSData+ZZFoundation.h
//  ZZFoundation
//
//  Created by Walker Stark on 10/23/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (ZZFoundation)

@property (nonatomic, copy, readonly) NSString *zz_MD5String;
@property (nonatomic, copy, readonly) NSString *zz_SHA1String;

@end

NS_ASSUME_NONNULL_END
