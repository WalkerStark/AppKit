//
//  NSArray+ZZFoundation.m
//  ZZFoundation
//
//  Created by Walker Stark on 10/23/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "NSArray+ZZFoundation.h"

@implementation NSArray (ZZFoundation)

- (NSArray *)zz_deepCopy
{
    return [[self zz_mutableDeepCopy] copy];
}

- (NSMutableArray *)zz_mutableDeepCopy
{
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:self.count];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id objCopy = nil;
        if ([obj respondsToSelector:@selector(zz_mutableDeepCopy)]) {
            objCopy = [obj zz_mutableDeepCopy];
        } else if ([obj respondsToSelector:@selector(mutableCopyWithZone:)]) {
            objCopy = [obj mutableCopy];
        } else if (objCopy == nil) {
            objCopy = [obj copy];
        }
        [mutableArray addObject:objCopy];
    }];
    
    return mutableArray;
}

@end
