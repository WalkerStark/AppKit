//
//  NSDate+ZZFoundation.m
//  ZZFoundation
//
//  Created by Walker Stark on 10/23/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import "NSDate+ZZFoundation.h"

@implementation NSDate (ZZFoundation)

+ (NSDateFormatter *)zz_sharedDateFormatter
{
    // Creating a date formatter is not a cheap operation.
    // If use a formatter frequently, it is typically more efficient to cache a single instance.
    static NSDateFormatter *_zz_sharedDateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _zz_sharedDateFormatter = [NSDateFormatter new];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:NSCurrentLocaleDidChangeNotification
                                                          object:nil
                                                           queue:NSOperationQueue.currentQueue
                                                      usingBlock:^(NSNotification * _Nonnull note) {
                                                          [_zz_sharedDateFormatter setLocale:NSLocale.autoupdatingCurrentLocale];
                                                      }];
    });
    return _zz_sharedDateFormatter;
}

#pragma mark - Format date time
#pragma mark -
- (NSString *)zz_shortDateString
{
    self.class.zz_sharedDateFormatter.doesRelativeDateFormatting = NO;
    [self.class.zz_sharedDateFormatter setDateStyle:NSDateFormatterShortStyle];
    [self.class.zz_sharedDateFormatter setTimeStyle:NSDateFormatterNoStyle];
    return [self.class.zz_sharedDateFormatter stringFromDate:self];
}

- (NSString *)zz_mediumDateString
{
    self.class.zz_sharedDateFormatter.doesRelativeDateFormatting = NO;
    [self.class.zz_sharedDateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [self.class.zz_sharedDateFormatter setTimeStyle:NSDateFormatterNoStyle];
    return [self.class.zz_sharedDateFormatter stringFromDate:self];
}

- (NSString *)zz_longDateString
{
    self.class.zz_sharedDateFormatter.doesRelativeDateFormatting = NO;
    [self.class.zz_sharedDateFormatter setDateStyle:NSDateFormatterLongStyle];
    [self.class.zz_sharedDateFormatter setTimeStyle:NSDateFormatterNoStyle];
    return [self.class.zz_sharedDateFormatter stringFromDate:self];
}

- (NSString *)zz_fullDateString
{
    self.class.zz_sharedDateFormatter.doesRelativeDateFormatting = NO;
    [self.class.zz_sharedDateFormatter setDateStyle:NSDateFormatterFullStyle];
    [self.class.zz_sharedDateFormatter setTimeStyle:NSDateFormatterNoStyle];
    return [self.class.zz_sharedDateFormatter stringFromDate:self];
}

- (NSString *)zz_shortTimeString
{
    [self.class.zz_sharedDateFormatter setDateStyle:NSDateFormatterNoStyle];
    [self.class.zz_sharedDateFormatter setTimeStyle:NSDateFormatterShortStyle];
    return [self.class.zz_sharedDateFormatter stringFromDate:self];
}

- (NSString *)zz_mediumTimeString
{
    [self.class.zz_sharedDateFormatter setDateStyle:NSDateFormatterNoStyle];
    [self.class.zz_sharedDateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    return [self.class.zz_sharedDateFormatter stringFromDate:self];
}

- (NSString *)zz_longTimeString
{
    [self.class.zz_sharedDateFormatter setDateStyle:NSDateFormatterNoStyle];
    [self.class.zz_sharedDateFormatter setTimeStyle:NSDateFormatterLongStyle];
    return [self.class.zz_sharedDateFormatter stringFromDate:self];
}

- (NSString *)zz_dateTimeString
{
    @synchronized(self) {
        return [NSString stringWithFormat:@"%@ %@", self.zz_shortDateString, self.zz_shortTimeString];
    }
}

- (NSString *)zz_relativeDateString
{
    self.class.zz_sharedDateFormatter.doesRelativeDateFormatting = YES;
    [self.class.zz_sharedDateFormatter setDateStyle:NSDateFormatterShortStyle];
    [self.class.zz_sharedDateFormatter setTimeStyle:NSDateFormatterNoStyle];
    return [self.class.zz_sharedDateFormatter stringFromDate:self];
}

- (NSString *)zz_relativeDateTimeString
{
    @synchronized(self) {
        return [NSString stringWithFormat:@"%@ %@", self.zz_relativeDateString, self.zz_shortTimeString];
    }
}

#pragma mark - Weekday
#pragma mark -
- (NSString *)zz_weekdaySymbol
{
    [self.class.zz_sharedDateFormatter setDateFormat:@"EEEE"];
    return [self.class.zz_sharedDateFormatter stringFromDate:self];
}

- (NSString *)zz_shortWeekdaySymbol
{
    [self.class.zz_sharedDateFormatter setDateFormat:@"EEEEEE"];
    return [self.class.zz_sharedDateFormatter stringFromDate:self];
}

- (NSString *)zz_tinyWeekdaySymbol
{
//    NSInteger weekdayIndex = [[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian] component:NSCalendarUnitWeekday fromDate:self];
//    return self.class.zz_sharedDateFormatter.veryShortWeekdaySymbols[weekdayIndex - 1];
    
    [self.class.zz_sharedDateFormatter setDateFormat:@"EEEEE"];
    return [self.class.zz_sharedDateFormatter stringFromDate:self];
}

#pragma mark - Day
#pragma mark -
- (BOOL)zz_isToday
{
    return [NSCalendar.currentCalendar isDateInToday:self];
}

- (BOOL)zz_isTomorrow
{
    return [NSCalendar.currentCalendar isDateInTomorrow:self];
}

- (BOOL)zz_isYesterday
{
    return [NSCalendar.currentCalendar isDateInYesterday:self];
}

- (BOOL)zz_isDayAfterTomorrow
{
    NSDate *date = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:self options:0];
    return date.zz_isTomorrow;
}

- (BOOL)zz_isDayBeforeYesterday
{
    NSDate *date = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:self options:0];
    return date.zz_isYesterday;
}

#pragma mark - Week
#pragma mark -
- (BOOL)zz_isWeekend
{
    return [NSCalendar.currentCalendar isDateInWeekend:self];
}

- (BOOL)zz_isThisWeek
{
    NSInteger week = [NSCalendar.currentCalendar component:NSCalendarUnitWeekOfYear fromDate:self];
    NSInteger thisWeek = [NSCalendar.currentCalendar component:NSCalendarUnitWeekOfYear fromDate:NSDate.date];
    return (week == thisWeek);
}

- (BOOL)zz_isLastWeek
{
    NSInteger week = [NSCalendar.currentCalendar component:NSCalendarUnitWeekOfYear fromDate:self];
    NSInteger thisWeek = [NSCalendar.currentCalendar component:NSCalendarUnitWeekOfYear fromDate:NSDate.date];
    return (week == thisWeek - 1);
}

- (BOOL)zz_isNextWeek
{
    NSInteger week = [NSCalendar.currentCalendar component:NSCalendarUnitWeekOfYear fromDate:self];
    NSInteger thisWeek = [NSCalendar.currentCalendar component:NSCalendarUnitWeekOfYear fromDate:NSDate.date];
    return (week == thisWeek + 1);
}

#pragma mark - Year
#pragma mark -
- (BOOL)zz_isThisYear
{
    NSInteger year = [NSCalendar.currentCalendar component:NSCalendarUnitYear fromDate:self];
    NSInteger thisYear = [NSCalendar.currentCalendar component:NSCalendarUnitYear fromDate:NSDate.date];
    return (year == thisYear);
}

- (BOOL)zz_isLastYear
{
    NSInteger year = [NSCalendar.currentCalendar component:NSCalendarUnitYear fromDate:self];
    NSInteger thisYear = [NSCalendar.currentCalendar component:NSCalendarUnitYear fromDate:NSDate.date];
    return (year == thisYear - 1);
}

- (BOOL)zz_isNextYear
{
    NSInteger year = [NSCalendar.currentCalendar component:NSCalendarUnitYear fromDate:self];
    NSInteger thisYear = [NSCalendar.currentCalendar component:NSCalendarUnitYear fromDate:NSDate.date];
    return (year == thisYear + 1);
}

@end
