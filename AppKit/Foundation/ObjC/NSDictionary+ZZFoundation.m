//
//  NSDictionary+ZZFoundation.m
//  ZZFoundation
//
//  Created by Walker Stark on 10/23/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "NSDictionary+ZZFoundation.h"

@implementation NSDictionary (ZZFoundation)

- (NSDictionary *)zz_deepCopy
{
    return [[self zz_mutableDeepCopy] copy];
}

- (NSMutableDictionary *)zz_mutableDeepCopy
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithCapacity:self.count];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        id objCopy = nil;
        if ([obj respondsToSelector:@selector(zz_mutableDeepCopy)]) {
            objCopy = [obj zz_mutableDeepCopy];
        } else if ([obj respondsToSelector:@selector(mutableCopyWithZone:)]) {
            objCopy = [obj mutableCopy];
        } else if (objCopy == nil) {
            objCopy = [obj copy];
        }
        [mutableDict setObject:objCopy forKey:key];
    }];
    
    return mutableDict;
}

@end
