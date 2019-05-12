//
//  NSUserDefaults+ZZFoundation.h
//  ZZFoundation
//
//  Created by Walker Stark on 10/24/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (ZZFoundation)

- (BOOL)zz_hasKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
