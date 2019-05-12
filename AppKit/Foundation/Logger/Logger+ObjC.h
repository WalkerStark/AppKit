//
//  Logger+ObjC.h
//  PDFoundation
//
//  Created by Walker Stark on 2019/2/20.
//  Copyright © 2019 Farfetch. All rights reserved.
//

@import Foundation;

void PDLogError(NSString *message, ...);
void PDLogWarning(NSString *message, ...);
void PDLogInfo(NSString *message, ...);
void PDLogDebug(NSString *message, ...);
void PDLogVerbose(NSString *message, ...);
