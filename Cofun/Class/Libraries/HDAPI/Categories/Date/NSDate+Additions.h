//
//  NSDate+Additions.h
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Additions)

@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger weekOfYear;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

///-----------------------------------------------------------------
///
///-----------------------------------------------------------------
+ (instancetype) getCurrentDateWithSystemTimeZone;
+ (instancetype) getCurrentDateWithTimeZone:(NSTimeZone *)timezone;

///-----------------------------------------------------------------
/// Returns the current date with the time set to midnight.
///-----------------------------------------------------------------
+ (instancetype) dateToday;

///-----------------------------------------------------------------
/// Relative dates from the current date
///-----------------------------------------------------------------
+ (instancetype) dateTomorrow;
+ (instancetype) dateYesterday;
+ (instancetype) dateWithDaysFromNow: (NSUInteger) days;
+ (instancetype) dateWithDaysBeforeNow: (NSUInteger) days;
+ (instancetype) dateWithHoursFromNow: (NSUInteger) dHours;
+ (instancetype) dateWithHoursBeforeNow: (NSUInteger) dHours;
+ (instancetype) dateWithMinutesFromNow: (NSUInteger) dMinutes;
+ (instancetype) dateWithMinutesBeforeNow: (NSUInteger) dMinutes;

///-----------------------------------------------------------------
/// Comparing dates
///-----------------------------------------------------------------
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;
- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;
- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;
- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;
- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;

///-----------------------------------------------------------------
/// Adjusting dates
///-----------------------------------------------------------------
- (NSDate *) dateByAddingDays: (NSUInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSUInteger) dDays;
- (NSDate *) dateByAddingHours: (NSUInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSUInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSUInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSUInteger) dMinutes;

///-----------------------------------------------------------------
/// Returns a copy of the date with the time set to 00:00:00 on the same day.
///-----------------------------------------------------------------
- (NSDate *) dateAtStartOfDay;

///-----------------------------------------------------------------
/// Returns a copy of the date with the time set to 23:59:59 on the same day.
///-----------------------------------------------------------------
- (NSDate *) dateAtEndOfDay;

///-----------------------------------------------------------------
/// Retrieving intervals
///-----------------------------------------------------------------
- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;

@end
