//
//  NSTimer+ZZFoundation.m
//  ZZFoundation
//
//  Created by Walker Stark on 10/23/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "NSTimer+ZZFoundation.h"

@implementation NSTimer (ZZFoundation)

+ (NSTimer *)zz_timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(nonnull ZZTimerBlock)block
{
    NSTimer *timer = [self timerWithTimeInterval:interval target:self selector:@selector(zz_actionDidFire:) userInfo:[block copy] repeats:repeats];
    [NSRunLoop.currentRunLoop addTimer:timer forMode:NSRunLoopCommonModes];
    return timer;
}

+ (NSTimer *)zz_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(ZZTimerBlock)block
{
    NSTimer *timer = [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(zz_actionDidFire:) userInfo:[block copy] repeats:repeats];
    [NSRunLoop.currentRunLoop addTimer:timer forMode:NSRunLoopCommonModes];
    return timer;
}

+ (void)zz_actionDidFire:(NSTimer *)timer
{
    ZZTimerBlock block = timer.userInfo;
    if (block) {
        block(timer);
    }
}

@end
