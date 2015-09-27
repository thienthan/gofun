//
//  NSDate+Extensions.h
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extensions)

///-----------------------------------------------------------------
/// Convert
///-----------------------------------------------------------------
- (NSString *)toString;                     // (06/15/2009)
- (NSString *)toStringWithFormat:(NSString *)dateFormatString;

- (NSString *)toStandardDateString;         // (06/15/2009)
- (NSString *)toShortDateString;            // (6/15/2009)
- (NSString *)toLongDateString;             // (Monday, June 15, 2009)
- (NSString *)toLongDateShortTimeString;    // (Monday, June 15, 2009 1:45 PM)
- (NSString *)toLongDateLongTimeString;     // (Monday, June 15, 2009 1:45:30 PM)
- (NSString *)toShortDateShortTimeString;   // (6/15/2009 1:45 PM)
- (NSString *)toShortDateLongTimeString;    // (6/15/2009 1:45:30 PM)
- (NSString *)toGeneralDateTimeString;            // (Mon, 15 Jun, 2009 at 13:45)
- (NSString *)toStandardDateTimeString;           // (2009-06-15 13:45:30)
- (NSString *)toDateTimeZoneString;
- (NSString *)toRFC1123String;              // (Mon, 15 Jun 2009 13:45:30 GMT)

- (NSString *)toStandardTimeString;         // (13:45:30)
- (NSString *)toShortTimeString;            // (1:45 PM)
- (NSString *)toLongTimeString;             // (1:45:30 PM)

- (NSString *)toMonthDayString;             // (June 15)
- (NSString *)toYearMonthString;            // (June, 2009)
- (NSString *)toMonthDayYearString;         // (Jun 15, 2009)

- (NSString *)toUTCStandardDateString;
- (NSString *)toUTCStandardDateTimeString;
- (NSString *)toUTCStringWithFormat:(NSString *)dateFormatString;

///-----------------------------------------------------------------
/// Getter
///-----------------------------------------------------------------
- (NSInteger)year;
- (NSInteger)quarter; // 1 -> 4
- (NSInteger)month; // 1 -> 12
- (NSInteger)weekOfYear; // 1 -> 53
- (NSInteger)weekday; // 1 -> 7 and Sunday is represented by 1.
- (NSInteger)weekOfMonth; // 1 -> 5
- (NSInteger)day; // 1 -> 31
- (NSInteger)dayOfYear; // 1 -> 365
- (NSInteger)dayOfWeekInMonth;
- (NSInteger)hour; // 0 -> 23
- (NSInteger)minute; // 0 -> 59
- (NSInteger)second; // 0 -> 59
- (NSInteger)secondOfDay; // 0 -> 86400

///-----------------------------------------------------------------
/// Retrieving Intervals
///-----------------------------------------------------------------
- (NSInteger)minutesAfterDate:(NSDate *)date;
- (NSInteger)minutesBeforeDate:(NSDate *)date;
- (NSInteger)hoursAfterDate:(NSDate *)date;
- (NSInteger)hoursBeforeDate:(NSDate *)date;
- (NSInteger)daysAfterDate:(NSDate *)date;
- (NSInteger)daysBeforeDate:(NSDate *)date;

///-----------------------------------------------------------------
/// Date
///-----------------------------------------------------------------
- (NSDate *)getDateIgnoringTime;
- (NSDate *)getDateTimeIgnoringSeconds;

+ (instancetype)dateFromString:(NSString *)string;
+ (instancetype)dateFromString:(NSString *)string withFormat:(NSString *)dateFormatString;
+ (instancetype)dateFromJSONString:(NSString *)string;
+ (instancetype)dateFromUTCString:(NSString *)string;
+ (instancetype)dateFromUTCString:(NSString *)string withFormat:(NSString *)dateFormatString;

+ (instancetype)currentDateWithSystemTimeZone;
+ (instancetype)currentDateWithTimeZone:(NSTimeZone *)timezone;

+ (instancetype)dateWithYearsFromNow:(NSUInteger)years;
+ (instancetype)dateWithYearsBeforeNow:(NSUInteger)years;
+ (instancetype)dateWithMonthsFromNow:(NSUInteger)months;
+ (instancetype)dateWithMonthsBeforeNow:(NSUInteger)months;
+ (instancetype)dateWithDaysFromNow:(NSUInteger)days;
+ (instancetype)dateWithDaysBeforeNow:(NSUInteger)days;

+ (instancetype)dateWithHoursFromNow:(NSUInteger)hours;
+ (instancetype)dateWithHoursBeforeNow:(NSUInteger)hours;
+ (instancetype)dateWithMinutesFromNow:(NSUInteger)minutes;
+ (instancetype)dateWithMinutesBeforeNow:(NSUInteger)minutes;

+ (instancetype)dateToday;
+ (instancetype)dateTomorrow;
+ (instancetype)dateYesterday;

- (NSDate *)dateByAddingYears:(NSUInteger)years;
- (NSDate *)dateBySubtractingYears:(NSUInteger)years;
- (NSDate *)dateByAddingMonths:(NSUInteger)months;
- (NSDate *)dateBySubtractingMonths:(NSUInteger)months;
- (NSDate *)dateByAddingDays:(NSUInteger)days;
- (NSDate *)dateBySubtractingDays:(NSUInteger)days;
- (NSDate *)dateByAddingHours:(NSUInteger)hours;
- (NSDate *)dateBySubtractingHours:(NSUInteger)hours;
- (NSDate *)dateByAddingMinutes:(NSUInteger)minutes;
- (NSDate *)dateBySubtractingMinutes:(NSUInteger)minutes;

///-----------------------------------------------------------------
/// Compare
///-----------------------------------------------------------------
- (NSInteger)compareDate:(NSDate *)date;
- (NSInteger)compareDateIgnoringTime:(NSDate *)date;
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)date;
- (BOOL)isToday;
- (BOOL)isTomorrow;
- (BOOL)isYesterday;
- (BOOL)isWithinRange:(NSDate *)startDate endDate:(NSDate *)endDate;
- (BOOL)isWithinRangeIgnoringTime:(NSDate *)startDate endDate:(NSDate *)endDate;

@end
