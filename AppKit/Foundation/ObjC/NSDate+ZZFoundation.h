//
//  NSDate+ZZFoundation.h
//  ZZFoundation
//
//  Created by Walker Stark on 10/23/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (ZZFoundation)

@property (nonatomic, copy, readonly) NSString *zz_shortDateString;         // e.g. "01/31/17"
@property (nonatomic, copy, readonly) NSString *zz_mediumDateString;        // e.g. "Jan 31, 2017"
@property (nonatomic, copy, readonly) NSString *zz_longDateString;          // e.g. "January 31, 2017"
@property (nonatomic, copy, readonly) NSString *zz_fullDateString;          // e.g. "Thuesday January 31, 2017"

@property (nonatomic, copy, readonly) NSString *zz_shortTimeString;         // e.g. "00:00 PM"
@property (nonatomic, copy, readonly) NSString *zz_mediumTimeString;        // e.g. "00:00:00 PM"
@property (nonatomic, copy, readonly) NSString *zz_longTimeString;          // e.g. "00:00:00 PM PST"

@property (nonatomic, copy, readonly) NSString *zz_dateTimeString;          // @{link zz_shortDateString} + @{link zz_shortTimeString}
@property (nonatomic, copy, readonly) NSString *zz_relativeDateString;      // Show Today, Tomorrow or Yesterday instead of actual date @{link zz_shortDateString}
@property (nonatomic, copy, readonly) NSString *zz_relativeDateTimeString;

@property (nonatomic, copy, readonly) NSString *zz_weekdaySymbol;           // e.g. "Friday"
@property (nonatomic, copy, readonly) NSString *zz_shortWeekdaySymbol;      // e.g. "Fr"
@property (nonatomic, copy, readonly) NSString *zz_tinyWeekdaySymbol;       // e.g. "S,M,T,W,T,F,S"

@property (nonatomic, assign, readonly) BOOL zz_isToday;
@property (nonatomic, assign, readonly) BOOL zz_isTomorrow;
@property (nonatomic, assign, readonly) BOOL zz_isYesterday;
@property (nonatomic, assign, readonly) BOOL zz_isDayAfterTomorrow;
@property (nonatomic, assign, readonly) BOOL zz_isDayBeforeYesterday;

@property (nonatomic, assign, readonly) BOOL zz_isWeekend;
@property (nonatomic, assign, readonly) BOOL zz_isThisWeek;
@property (nonatomic, assign, readonly) BOOL zz_isLastWeek;
@property (nonatomic, assign, readonly) BOOL zz_isNextWeek;

@property (nonatomic, assign, readonly) BOOL zz_isThisYear;
@property (nonatomic, assign, readonly) BOOL zz_isLastYear;
@property (nonatomic, assign, readonly) BOOL zz_isNextYear;

@end

NS_ASSUME_NONNULL_END
