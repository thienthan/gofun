//
//  NSString+Extensions.h
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extensions)

///-----------------------------------------------------------------
/// Date
///-----------------------------------------------------------------
- (NSDate *)toDate;
- (NSDate *)toDateWithFormat:(NSString *)dateFormatString;
+ (instancetype)getStringCurrentDateOnly;
+ (instancetype)getStringDateOnly:(NSDate *)date;
+ (instancetype)stringFromDate:(NSDate *)date;
+ (instancetype)stringFromDate:(NSDate *)date withFormat:(NSString *)dateFormatString;
+ (instancetype)timeStringFromSeconds:(long)seconds;
+ (instancetype)shortTimeStringFromSeconds:(long)seconds;
- (NSString *)stringFromJSONStringDate;

///-----------------------------------------------------------------
/// Format
///-----------------------------------------------------------------
- (NSString *)numberFormatterCurrency;
- (NSString *)unNumberFormatterCurrency;
- (NSString *)numberFormatterComma;
- (NSString *)unNumberFormatterComma;
- (NSString *)numberFormatterPhoneUS;
- (NSString *)unNumberFormatterPhoneUS;
- (NSString *)numberFormatterPostalCodeUS;
- (NSString *)unNumberFormatterPostalCodeUS;

///-----------------------------------------------------------------
/// Trim + Reverse
///-----------------------------------------------------------------
- (NSString *)trimByWhiteSpace;
- (NSString *)trimByWhitespaceAndNewline;
- (NSString*)reverseString;
- (NSString *)stringByStrippingHTML;//combine with stringByUnescapingFromHTML (NSString+HTML.h) to remove special characters

///-----------------------------------------------------------------
/// Host
///-----------------------------------------------------------------
- (NSString*)domainNameFromUrlAddress;
- (NSString*)hostNameFromUrlAddress;

- (NSString *)encodeURI;
- (NSString *)decodeURI;

- (NSString *)urlEncodeString;

///-----------------------------------------------------------------
/// Check
///-----------------------------------------------------------------
- (BOOL)containsString:(NSString *)string;

+ (BOOL)isValidEmail:(NSString *)email;
+ (BOOL)isValidPhoneUS:(NSString *)phoneNumber;
+ (BOOL)isValidPostalCodeUS:(NSString *)postalCode;
+ (BOOL)isValidPostalCode:(NSString *)postalCode countryCode:(NSString *)countryCode;
+ (BOOL)isNumber:(NSString *)number;
+ (BOOL)isNumberWithComma:(NSString *)number;
+ (BOOL)isAlphabet:(NSString *)string;
+ (BOOL)isAlphanumeric:(NSString *)string;
+ (BOOL)isValidURL:(NSString *)string;
+ (BOOL)isValidString:(NSString *)string withRegex:(NSString *)regex;

+ (BOOL)validateString:(NSString *)string withPattern:(NSString *)pattern;

///-----------------------------------------------------------------
/// Hashes
///-----------------------------------------------------------------
- (NSString *)md5;
- (NSString *)sha1;
- (NSString *)sha256;
- (NSString *)sha512;

- (NSData *)md5Data;
- (NSData *)sha1Data;
- (NSData *)sha256Data;
- (NSData *)sha512Data;

///-----------------------------------------------------------------
/// Substring
///-----------------------------------------------------------------
- (NSString *)substringFrom:(NSInteger)from to:(NSInteger)to;

///-----------------------------------------------------------------
/// Sign
///-----------------------------------------------------------------
+ (instancetype)centSign;
+ (instancetype)poundSign;
+ (instancetype)currencySign;
+ (instancetype)yenSign;
+ (instancetype)brokenVerticalBar;
+ (instancetype)sectionSign;
+ (instancetype)copyrightSign;
+ (instancetype)registeredTradeMarkSign;
+ (instancetype)degreeSign;
+ (instancetype)plusOrMinusSign;
+ (instancetype)microSign;
+ (instancetype)fractionOneQuarter;
+ (instancetype)fractionOneHalf;
+ (instancetype)fractionThreeQuarters;
+ (instancetype)invertedQuestionMark;
+ (instancetype)euroSign;
+ (instancetype)tradeMarkSign;
+ (instancetype)perThousandSign;
+ (instancetype)bullet;

@end
