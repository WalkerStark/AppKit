//
//  Logger+ObjC.m
//  PDFoundation
//
//  Created by Walker Stark on 2019/2/20.
//  Copyright © 2019 Farfetch. All rights reserved.
//

#import "Logger+ObjC.h"
#import <AppKit/AppKit-Swift.h>

void PDLogError(NSString *message, ...)
{
    va_list args;
    va_start(args, message);
    [Logger error:[[NSString alloc] initWithFormat:message arguments:args]];
    va_end(args);
}

void PDLogWarning(NSString *message, ...)
{
    va_list args;
    va_start(args, message);
    [Logger warning:[[NSString alloc] initWithFormat:message arguments:args]];
    va_end(args);
}

void PDLogInfo(NSString *message, ...)
{
    va_list args;
    va_start(args, message);
    [Logger info:[[NSString alloc] initWithFormat:message arguments:args]];
    va_end(args);
}

void PDLogDebug(NSString *message, ...)
{
    va_list args;
    va_start(args, message);
    [Logger debug:[[NSString alloc] initWithFormat:message arguments:args]];
    va_end(args);
}

void PDLogVerbose(NSString *message, ...)
{
    va_list args;
    va_start(args, message);
    [Logger verbose:[[NSString alloc] initWithFormat:message arguments:args]];
    va_end(args);
}
