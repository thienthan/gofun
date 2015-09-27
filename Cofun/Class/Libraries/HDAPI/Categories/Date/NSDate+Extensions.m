//
//  NSDate+Extensions.m
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import "NSDate+Extensions.h"

#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

#if !__has_feature(objc_instancetype)
#error This library requires instancetype
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//#error This library requires iOS 7.0 or higher
#endif

#define STANDARD_DATE_FORMAT @"MM/dd/yyyy"
#define SHORT_DATE_FORMAT @"M/d/yyyy"
#define LONG_DATE_FORMAT @"EEEE, MMMM d, yyyy"
#define LONG_DATE_SHORT_TIME_FORMAT @"EEEE, MMMM d, yyyy h:m a"
#define LONG_DATE_LONG_TIME_FORMAT @"EEEE, MMMM d, yyyy h:m:s a"
#define SHORT_DATE_SHORT_TIME_FORMAT @"M/d/yyyy h:m a"
#define SHORT_DATE_LONG_TIME_FORMAT @"M/d/yyyy h:m:s a"
#define GENERAL_DATE_TIME_FORMAT @"EEE, d MMM, yyyy 'at' HH:mm"
#define STANDARD_DATE_TIME_FORMAT @"yyyy-MM-dd HH:mm:ss"
#define DATE_TIME_ZONE_FORMAT @"yyyy-MM-dd HH:mm:ss z"
#define RFC1123_FORMAT @"EEE, d MMM yyyy HH:mm:ss zzz"
#define STANDARD_TIME_FORMAT @"HH:mm:ss"
#define SHORT_TIME_FORMAT @"h:m a"
#define LONG_TIME_FORMAT @"h:m:s a"
#define MONTH_DAY_FORMAT @"MMMM d"
#define YEAR_MONTH_FORMAT @"MMMM, yyyy"
#define MONTH_DAY_YEAR_FORMAT @"MMM d, yyyy"

#define D_MINUTE 60
#define D_HOUR 3600
#define D_DAY 86400
#define D_WEEK 604800
#define D_YEAR 31556926

#define DATE_TIME_COMPONENTS (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekOfMonthCalendarUnit |NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit)
#define DATE_HM_COMPONENTS (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekOfMonthCalendarUnit |NSHourCalendarUnit | NSMinuteCalendarUnit)
#define DATE_COMPONENTS (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
#define TIME_COMPONENTS (NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit)

#define CURRENT_CALENDAR [NSCalendar currentCalendar]
#define GREGORIAN_CALENDAR [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]

@implementation NSDate (Extensions)

#pragma mark - Convert
- (NSString *)toString {
    // (06/15/2009)
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:self];
    
    return strDate;
}

- (NSString *)toStringWithFormat:(NSString *)dateFormatString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormatString];
    NSString *strDate = [dateFormatter stringFromDate:self];
    
    return strDate;
}

- (NSString *)toStandardDateString {
    
    return [self toStringWithFormat:STANDARD_DATE_FORMAT];
}

- (NSString *)toShortDateString {
    
    return [self toStringWithFormat:SHORT_DATE_FORMAT];
}

- (NSString *)toLongDateString {
    
    return [self toStringWithFormat:LONG_DATE_FORMAT];
}

- (NSString *)toLongDateShortTimeString {
    
    return [self toStringWithFormat:LONG_DATE_SHORT_TIME_FORMAT];
}

- (NSString *)toLongDateLongTimeString {
    
    return [self toStringWithFormat:LONG_DATE_LONG_TIME_FORMAT];
}

- (NSString *)toShortDateShortTimeString {
    
    return [self toStringWithFormat:SHORT_DATE_SHORT_TIME_FORMAT];
}

- (NSString *)toShortDateLongTimeString {
    
    return [self toStringWithFormat:SHORT_DATE_LONG_TIME_FORMAT];
}

- (NSString *)toGeneralDateTimeString {
    
    return [self toStringWithFormat:GENERAL_DATE_TIME_FORMAT];
}

- (NSString *)toStandardDateTimeString {
    
    return [self toStringWithFormat:STANDARD_DATE_TIME_FORMAT];
}

- (NSString *)toDateTimeZoneString {
    
    return [self toStringWithFormat:DATE_TIME_ZONE_FORMAT];
}

- (NSString *)toRFC1123String {
    
    return [self toStringWithFormat:RFC1123_FORMAT];
}

- (NSString *)toStandardTimeString {
    
    return [self toStringWithFormat:STANDARD_TIME_FORMAT];
}

- (NSString *)toShortTimeString {
    
    return [self toStringWithFormat:SHORT_TIME_FORMAT];
}

- (NSString *)toLongTimeString {
    
    return [self toStringWithFormat:LONG_TIME_FORMAT];
}

- (NSString *)toMonthDayString {
    
    return [self toStringWithFormat:MONTH_DAY_FORMAT];
}

- (NSString *)toYearMonthString {
    
    return [self toStringWithFormat:YEAR_MONTH_FORMAT];
}

- (NSString *)toMonthDayYearString {
    
    return [self toStringWithFormat:MONTH_DAY_YEAR_FORMAT];
}

- (NSString *)toUTCStringWithFormat:(NSString *)dateFormatString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:dateFormatString];
    NSString *dateString = [dateFormatter stringFromDate:self];
    
    return dateString;
}

- (NSString *)toUTCStandardDateTimeString {
    
    return [self toUTCStringWithFormat:STANDARD_DATE_TIME_FORMAT];
}

- (NSString *)toUTCStandardDateString {
    
    return [self toUTCStringWithFormat:STANDARD_DATE_FORMAT];
}

#pragma mark - Getter
- (NSInteger)year {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_TIME_COMPONENTS fromDate:self];
    
    return [components year];
}

- (NSInteger)quarter {
    
    NSString *s = [self toStringWithFormat:@"Q"];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    return [[formatter numberFromString:s] integerValue];
}

- (NSInteger)month {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_TIME_COMPONENTS fromDate:self];
    
    return [components month];
}

- (NSInteger)weekOfYear {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_TIME_COMPONENTS fromDate:self];
    
    return [components weekOfYear];
}

- (NSInteger)weekday {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_TIME_COMPONENTS fromDate:self];
    
    return [components weekday];
}

- (NSInteger)weekOfMonth {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_TIME_COMPONENTS fromDate:self];
    
    return [components weekOfMonth];
}

- (NSInteger)day {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_TIME_COMPONENTS fromDate:self];
    
    return [components day];
}

- (NSInteger)dayOfYear {
    
    NSString *s = [self toStringWithFormat:@"D"];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    return [[formatter numberFromString:s] integerValue];
}

- (NSInteger)dayOfWeekInMonth {
    
    NSString *s = [self toStringWithFormat:@"F"];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    return [[formatter numberFromString:s] integerValue];
}

- (NSInteger)hour {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_TIME_COMPONENTS fromDate:self];
    
    return [components hour];
}

- (NSInteger)minute {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_TIME_COMPONENTS fromDate:self];
    
    return [components minute];
}

- (NSInteger)second {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_TIME_COMPONENTS fromDate:self];
    
    return [components second];
}

- (NSInteger)secondOfDay {
    
    return ([self hour] * D_HOUR) + ([self minute] * D_MINUTE) + [self second];
}

#pragma mark - Retrieving Intervals
- (NSInteger)minutesAfterDate:(NSDate *)date {
    
    NSTimeInterval ti = [self timeIntervalSinceDate:date];
    
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger)minutesBeforeDate:(NSDate *)date {
    
    NSTimeInterval ti = [date timeIntervalSinceDate:self];
    
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger)hoursAfterDate:(NSDate *)date {
    
    NSTimeInterval ti = [self timeIntervalSinceDate:date];
    
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger)hoursBeforeDate:(NSDate *)date {
    
    NSTimeInterval ti = [date timeIntervalSinceDate:self];
    
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger)daysAfterDate:(NSDate *)date {
    
    NSTimeInterval ti = [self timeIntervalSinceDate:date];
    
    return (NSInteger) (ti / D_DAY);
}

- (NSInteger)daysBeforeDate:(NSDate *)date {
    
    NSTimeInterval ti = [date timeIntervalSinceDate:self];
    
    return (NSInteger) (ti / D_DAY);
}

#pragma mark - Date
- (NSDate *)getDateIgnoringTime {
    
    NSCalendar *gregorianCalendar = GREGORIAN_CALENDAR;
    
    NSDateComponents *oneComponents = [gregorianCalendar components:DATE_COMPONENTS fromDate:self];
    NSDate *dateIgnoringTime = [gregorianCalendar dateFromComponents:oneComponents];
    
    return dateIgnoringTime;
}

- (NSDate *)getDateTimeIgnoringSeconds {
    
    NSCalendar *gregorianCalendar = GREGORIAN_CALENDAR;
    
    NSDateComponents *oneComponents = [gregorianCalendar components:DATE_HM_COMPONENTS fromDate:self];
    NSDate *dateTimeIgnoringSeconds = [gregorianCalendar dateFromComponents:oneComponents];
    
    return dateTimeIgnoringSeconds;
}

+ (instancetype)dateFromString:(NSString *)string {
    
    return [self dateFromString:string withFormat:STANDARD_DATE_FORMAT];
}

+ (instancetype)dateFromString:(NSString *)string withFormat:(NSString *)dateFormatString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormatString];
    NSDate *date = [dateFormatter dateFromString:string];
    
    return date;
}

+ (instancetype)dateFromJSONString:(NSString *)string {
    
    // Expect date in this format "/Date(1268123281843)/"
    unsigned long startPos = [string rangeOfString:@"("].location+1;
    unsigned long endPos = [string rangeOfString:@")"].location;
    NSRange range = NSMakeRange(startPos, endPos-startPos);
    
    unsigned long long milliseconds = [[string substringWithRange:range] longLongValue];
    //NSLog(@"%llu",milliseconds);
    NSTimeInterval interval = milliseconds/1000;
    return [NSDate dateWithTimeIntervalSince1970:interval];
}

+ (instancetype)dateFromUTCString:(NSString *)string {
    
    return [self dateFromUTCString:string withFormat:STANDARD_DATE_TIME_FORMAT];
}

+ (instancetype)dateFromUTCString:(NSString *)string withFormat:(NSString *)dateFormatString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:dateFormatString];
    NSDate *date = [dateFormatter dateFromString:string];
    
    return date;
}

+ (instancetype)currentDateWithSystemTimeZone {
    
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    
    NSDate *localeDate = [date dateByAddingTimeInterval:interval];
    
    //NSLog(@"%@", localeDate);
    
    return localeDate;
}

+ (instancetype)currentDateWithTimeZone:(NSTimeZone *)timezone {
    
    NSDate *date = [NSDate date];
    NSInteger interval = [timezone secondsFromGMTForDate: date];
    
    NSDate *localeDate = [date dateByAddingTimeInterval:interval];
    
    //NSLog(@"%@", localeDate);
    
    return localeDate;
}

+ (instancetype)dateWithYearsFromNow:(NSUInteger)years {
    
    /*
    NSDateComponents *components = [NSDateComponents new];
    components.year = years;
    
    return [CURRENT_CALENDAR dateByAddingComponents:components
                                             toDate:[NSDate date]
                                            options:0];
     */
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:[NSDate date]];
    [components setYear:[components year] + years];
    
    return [CURRENT_CALENDAR dateFromComponents:components];
}

+ (instancetype)dateWithYearsBeforeNow:(NSUInteger)years {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:[NSDate date]];
    [components setYear:[components year] - years];
    
    return [CURRENT_CALENDAR dateFromComponents:components];
}

+ (instancetype)dateWithMonthsFromNow:(NSUInteger)months {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:[NSDate date]];
    [components setMonth:[components month] + months];
    
    return [CURRENT_CALENDAR dateFromComponents:components];
}

+ (instancetype)dateWithMonthsBeforeNow:(NSUInteger)months {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:[NSDate date]];
    [components setMonth:[components month] - months];
    
    return [CURRENT_CALENDAR dateFromComponents:components];
}

+ (instancetype)dateWithDaysFromNow:(NSUInteger)days {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_DAY * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return newDate;
}

+ (instancetype)dateWithDaysBeforeNow:(NSUInteger)days {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_DAY * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return newDate;
}

+ (instancetype)dateWithHoursFromNow:(NSUInteger)hours {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return newDate;
}

+ (instancetype)dateWithHoursBeforeNow:(NSUInteger)hours {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return newDate;
}

+ (instancetype)dateWithMinutesFromNow:(NSUInteger)minutes {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return newDate;
}

+ (instancetype)dateWithMinutesBeforeNow:(NSUInteger)dMinutes {
    
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return newDate;
}

+ (instancetype)dateToday {
    
    return [NSDate dateWithDaysFromNow:0];
}

+ (instancetype)dateTomorrow {
    
    return [NSDate dateWithDaysFromNow:1];
}

+ (instancetype)dateYesterday {
    
    return [NSDate dateWithDaysBeforeNow:1];
}

- (NSDate *)dateByAddingYears:(NSUInteger)years {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    [components setYear:[components year] + years];
    
    return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDate *)dateBySubtractingYears:(NSUInteger)years {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    [components setYear:[components year] - years];
    
    return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDate *)dateByAddingMonths:(NSUInteger)months {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    [components setMonth:[components month] + months];
    
    return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDate *)dateBySubtractingMonths:(NSUInteger)months {
    
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    [components setMonth:[components month] - months];
    
    return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDate *)dateByAddingDays:(NSUInteger)days {
    
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_DAY * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return newDate;
}

- (NSDate *)dateBySubtractingDays:(NSUInteger)days {
    
    return [self dateByAddingDays: (days * -1)];
}

- (NSDate *)dateByAddingHours:(NSUInteger)hours {
    
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return newDate;
}

- (NSDate *)dateBySubtractingHours:(NSUInteger)hours {
    
    return [self dateByAddingHours: (hours * -1)];
}

- (NSDate *)dateByAddingMinutes:(NSUInteger)minutes {
    
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    
    return newDate;
}

- (NSDate *)dateBySubtractingMinutes:(NSUInteger)minutes {
    
    return [self dateByAddingMinutes: (minutes * -1)];
}

#pragma mark - Compare
- (NSInteger)compareDate:(NSDate *)date {
    
    NSComparisonResult result = [self compare:date];
    NSInteger returnCode = 0;
    
    switch (result) {
        case NSOrderedAscending:
            // dateOne is earlier in time than dateTwo
            returnCode = -1;
            break;
        case NSOrderedSame:
            // The dates are the same
            returnCode = 0;
            break;
        case NSOrderedDescending:
            // dateOne is later in time than dateTwo
            returnCode = 1;
            break;
    }
    
    return returnCode;
}

- (NSInteger)compareDateIgnoringTime:(NSDate *)date {
    
    return [[self getDateIgnoringTime] compareDate:[date getDateIgnoringTime]];
}

- (BOOL)isEqualToDateIgnoringTime:(NSDate *)date {
    
    return [self compareDateIgnoringTime:date] == 0;
}

- (BOOL)isToday {
    
    return [self isEqualToDateIgnoringTime:[NSDate dateToday]];
}

- (BOOL)isTomorrow {
    
    return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL)isYesterday {
    
    return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

- (BOOL)isWithinRange:(NSDate *)startDate endDate:(NSDate *)endDate {
    
    return ([self compareDate:startDate] >= 0) && ([self compareDate:endDate] <= 0);
}

- (BOOL)isWithinRangeIgnoringTime:(NSDate *)startDate endDate:(NSDate *)endDate {
    
    return ([self compareDateIgnoringTime:startDate] >= 0) && ([self compareDateIgnoringTime:endDate] <= 0);
}

@end
