//
//  NSDictionary+ZZFoundation.h
//  ZZFoundation
//
//  Created by Walker Stark on 10/23/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (ZZFoundation)

- (NSDictionary *)zz_deepCopy;
- (NSMutableDictionary *)zz_mutableDeepCopy;

@end

NS_ASSUME_NONNULL_END
