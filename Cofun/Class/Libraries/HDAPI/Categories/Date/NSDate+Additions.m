//
//  NSDate+Additions.m
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import "NSDate+Additions.h"

#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

#if !__has_feature(objc_instancetype)
#error This library requires instancetype
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//#error This library requires iOS 7.0 or higher
#endif

#define D_MINUTE 60
#define D_HOUR 3600
#define D_DAY 86400
#define D_WEEK 604800
#define D_YEAR 31556926

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

@implementation NSDate (Additions)

#pragma mark - Relative Dates

+ (NSDate *)getCurrentDateWithSystemTimeZone {
    
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    
    NSDate *localeDate = [date dateByAddingTimeInterval:interval];
    
    //NSLog(@"%@", localeDate);
    
    return localeDate;
}

+ (NSDate *)getCurrentDateWithTimeZone:(NSTimeZone *)timezone {
    
    NSDate *date = [NSDate date];
    NSInteger interval = [timezone secondsFromGMTForDate: date];
    
    NSDate *localeDate = [date dateByAddingTimeInterval:interval];
    
    //NSLog(@"%@", localeDate);
    
    return localeDate;
}

+ (NSDate *)dateWithDaysFromNow:(NSUInteger)days {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_DAY * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return newDate;
}

+ (NSDate *)dateWithDaysBeforeNow:(NSUInteger)days {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_DAY * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return newDate;
}

+ (NSDate *)dateWithHoursFromNow:(NSUInteger)dHours {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return newDate;
}

+ (NSDate *)dateWithHoursBeforeNow:(NSUInteger)dHours {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return newDate;
}

+ (NSDate *)dateWithMinutesFromNow:(NSUInteger)dMinutes {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return newDate;
}

+ (NSDate *)dateWithMinutesBeforeNow:(NSUInteger)dMinutes {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return newDate;
}

+ (NSDate *)dateToday {
    
    return [NSDate dateWithDaysFromNow:0];
}

+ (NSDate *)dateTomorrow {
    
    return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *)dateYesterday {
    
    return [NSDate dateWithDaysBeforeNow:1];
}

#pragma mark - Comparing Dates
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [calendar setTimeZone:GTMzone];
    NSDateComponents *components1 = [calendar components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [calendar components:DATE_COMPONENTS fromDate:aDate];
    //NSLog(@"%d, %d -- %d, %d -- %d, %d", [components1 year], [components2 year], [components1 month], [components2 month], [components1 day], [components2 day]);
    return (([components1 year] == [components2 year]) &&
            ([components1 month] == [components2 month]) &&
            ([components1 day] == [components2 day]));
}

- (BOOL)isToday {
    
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL)isTomorrow {
    
    return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL)isYesterday {
    
    return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL)isSameWeekAsDate:(NSDate *)aDate {
    
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if ([components1 weekOfYear] != [components2 weekOfYear]) return NO;
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

- (BOOL)isThisWeek {
    
    return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL)isNextWeek {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return [self isSameYearAsDate:newDate];
}

- (BOOL)isLastWeek {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return [self isSameYearAsDate:newDate];
}

- (BOOL)isSameYearAsDate:(NSDate *)aDate {
    
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:aDate];
    
    return ([components1 year] == [components2 year]);
}

- (BOOL)isThisYear {
    
    return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL)isNextYear {
    
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
    
    return ([components1 year] == ([components2 year] + 1));
}

- (BOOL)isLastYear {
    
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
    
    return ([components1 year] == ([components2 year] - 1));
}

- (BOOL)isEarlierThanDate:(NSDate *)aDate {
    
    return ([self earlierDate:aDate] == self);
}

- (BOOL)isLaterThanDate:(NSDate *)aDate {
    
    return ([self laterDate:aDate] == self);
}

#pragma mark - Adjusting Dates
- (NSDate *)dateByAddingDays:(NSUInteger)dDays {
    
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_DAY * dDays;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return newDate;
}

- (NSDate *)dateBySubtractingDays:(NSUInteger)dDays {
    
    return [self dateByAddingDays: (dDays * -1)];
}

- (NSDate *)dateByAddingHours:(NSUInteger)dHours {
    
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return newDate;
}

- (NSDate *)dateBySubtractingHours:(NSUInteger)dHours {
    
    return [self dateByAddingHours: (dHours * -1)];
}

- (NSDate *)dateByAddingMinutes:(NSUInteger)dMinutes {
    
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return newDate;
}

- (NSDate *)dateBySubtractingMinutes:(NSUInteger)dMinutes {
    
    return [self dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDate *)dateAtStartOfDay {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    
    return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDate *)dateAtEndOfDay {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];
    
    return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDateComponents *)componentsWithOffsetFromDate:(NSDate *)aDate {
    
    NSDateComponents *dTime = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate toDate:self options:0];
    
    return dTime;
}

#pragma mark - Retrieving Intervals
- (NSInteger)minutesAfterDate:(NSDate *)aDate {
    
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger)minutesBeforeDate:(NSDate *)aDate {
    
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger)hoursAfterDate:(NSDate *)aDate {
    
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger)hoursBeforeDate:(NSDate *)aDate{
    
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger)daysAfterDate:(NSDate *)aDate {
    
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    
    return (NSInteger) (ti / D_DAY);
}

- (NSInteger)daysBeforeDate:(NSDate *)aDate {
    
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    
    return (NSInteger) (ti / D_DAY);
}

#pragma mark - Decomposing Dates
- (NSInteger)nearestHour {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [CURRENT_CALENDAR components:NSHourCalendarUnit fromDate:newDate];
    
    return [components hour];
}

- (NSInteger)hour {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    
    return [components hour];
}

- (NSInteger)minute {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    
    return [components minute];
}

- (NSInteger)seconds {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    
    return [components second];
}

- (NSInteger)day {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    
    return [components day];
}

- (NSInteger)month {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    
    return [components month];
}

- (NSInteger)weekOfYear {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    
    return [components weekOfYear];
}

- (NSInteger)weekday {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    
    return [components weekday];
}

- (NSInteger)nthWeekday {
    // e.g. 2nd Tuesday of the month is 2
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    
    return [components weekdayOrdinal];
}

- (NSInteger)year {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    
    return [components year];
}

@end