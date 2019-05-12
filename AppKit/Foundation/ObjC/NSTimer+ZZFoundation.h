//
//  NSTimer+ZZFoundation.h
//  ZZFoundation
//
//  Created by Walker Stark on 10/23/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ZZTimerBlock)(NSTimer *timer);

@interface NSTimer (ZZFoundation)

+ (NSTimer *)zz_timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(ZZTimerBlock)block;
+ (NSTimer *)zz_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(ZZTimerBlock)block;

@end

NS_ASSUME_NONNULL_END
