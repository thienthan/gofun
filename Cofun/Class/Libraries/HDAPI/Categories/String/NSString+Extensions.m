//
//  NSString+Extensions.m
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import "NSString+Extensions.h"
#import <CommonCrypto/CommonDigest.h>

#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

#if !__has_feature(objc_instancetype)
#error This library requires instancetype
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//#error This library requires iOS 7.0 or higher
#endif

@implementation NSString (Extensions)

///---------------------------------------------------------------------------------------
/// Date
///---------------------------------------------------------------------------------------
#pragma mark - Date
- (NSDate *)toDate{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    //[dateFormatter setDateFormat:@"MM/dd/yyyy HH:mm:ss A a z"];
    NSDate *date = [dateFormatter dateFromString:self];
    
    return date;
}

- (NSDate *)toDateWithFormat:(NSString *)dateFormatString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormatString];
    NSDate *date = [dateFormatter dateFromString:self];
    
    return date;
}

+ (instancetype)getStringCurrentDateOnly{
    
    NSDate *now = [NSDate date];
    
    return [self stringFromDate:now];
}

+ (instancetype)getStringDateOnly:(NSDate *)date {
    
    return [self stringFromDate:date];
}

+ (instancetype)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    
    return strDate;
}

+ (instancetype)stringFromDate:(NSDate *)date withFormat:(NSString *)dateFormatString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormatString];
    NSString *strDate = [dateFormatter stringFromDate:date];
    
    return strDate;
}

+ (instancetype)timeStringFromSeconds:(long)seconds {
    
    // extract hours
    long mHours = floor(seconds / (60 * 60));
    
    // extract minutes
    long divisor_for_minutes = seconds % (60 * 60);
    long mMinutes = floor(divisor_for_minutes / 60);
    
    // extract the remaining seconds
    long divisor_for_seconds = divisor_for_minutes % 60;
    long mSeconds = ceil(divisor_for_seconds);
    
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", mHours, mMinutes, mSeconds];
}

+ (instancetype)shortTimeStringFromSeconds:(long)seconds {
    
    // extract minutes
    long divisor_for_minutes = seconds % (60 * 60);
    long mMinutes = floor(divisor_for_minutes / 60);
    
    // extract the remaining seconds
    long divisor_for_seconds = divisor_for_minutes % 60;
    long mSeconds = ceil(divisor_for_seconds);
    
    return [NSString stringWithFormat:@"%02ld:%02ld", mMinutes, mSeconds];
}

- (NSString *)stringFromJSONStringDate {
    
    // Expect date in this format "/Date(1268123281843)/"
    unsigned long startPos = [self rangeOfString:@"("].location+1;
    unsigned long endPos = [self rangeOfString:@")"].location;
    NSRange range = NSMakeRange(startPos, endPos-startPos);
    
    unsigned long long milliseconds = [[self substringWithRange:range] longLongValue];
    //NSLog(@"%llu",milliseconds);
    NSTimeInterval interval = milliseconds/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    
    return strDate;
}

///---------------------------------------------------------------------------------------
/// Format
///---------------------------------------------------------------------------------------
#pragma mark - Format
- (NSString *)numberFormatterCurrency{
    
    NSLocale* usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
    
    NSNumberFormatter *numberFormatter=[[NSNumberFormatter alloc]init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setLocale:usLocale];
    
    NSString *returnString = [numberFormatter stringFromNumber:[NSNumber numberWithLongLong:[self longLongValue]]];
    if (returnString.length>3) {
        returnString = [returnString substringToIndex:returnString.length-3];
    }
    
    return returnString;
}

- (NSString *)unNumberFormatterCurrency{
    
    NSLocale* usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
    
    NSNumberFormatter *formatter=[[NSNumberFormatter alloc]init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setLocale:usLocale];
    
    NSNumber *returnNumber = [formatter numberFromString:self];
    
    return [returnNumber stringValue];
}

- (NSString *)numberFormatterComma{
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setGroupingSeparator:@","];
    
    NSString* returnString = [numberFormatter stringForObjectValue:[NSNumber numberWithLongLong:[self longLongValue]]];
    
    return returnString;
}

- (NSString *)unNumberFormatterComma{
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setGroupingSeparator:@","];
    
    NSNumber* returnNumber = [numberFormatter numberFromString:self];
    
    return [returnNumber stringValue];
}

- (NSString *)numberFormatterPhoneUS {
    
    NSString *phoneNumber = self;
    if (self.length == 10) {
        phoneNumber = [NSString stringWithFormat:@"(%@) %@-%@", [self substringWithRange:NSMakeRange(0, 3)],[self substringWithRange:NSMakeRange(3, 3)],[self substringWithRange:NSMakeRange(6, 4)]];
    }
    
    return phoneNumber;
}

- (NSString *)unNumberFormatterPhoneUS {
    
    NSString *number = self;
    number = [number stringByReplacingOccurrencesOfString:@"+" withString:@""];
    number = [number stringByReplacingOccurrencesOfString:@"(" withString:@""];
    number = [number stringByReplacingOccurrencesOfString:@")" withString:@""];
    number = [number stringByReplacingOccurrencesOfString:@"-" withString:@""];
    number = [number stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return number;
}

- (NSString *)numberFormatterPostalCodeUS {
    
    NSString *postalCode = self;
    if (self.length == 9) {
        postalCode = [NSString stringWithFormat:@"%@-%@", [self substringWithRange:NSMakeRange(0, 5)],[self substringWithRange:NSMakeRange(5, 4)]];
    }
    
    return postalCode;
}

- (NSString *)unNumberFormatterPostalCodeUS {
    NSString *number = self;
    number = [number stringByReplacingOccurrencesOfString:@"-" withString:@""];
    number = [number stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return number;
}

///---------------------------------------------------------------------------------------
/// Trim + Reverse
///---------------------------------------------------------------------------------------
#pragma mark - Trim
- (NSString *)trimByWhiteSpace{
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)trimByWhitespaceAndNewline{
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)stringByAddingPercentEscapes {
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)stringByStrippingHTML {
    
    NSMutableString *outString = [[NSMutableString alloc] initWithString:self];
    
    if ([self length] > 0) {
        
        NSRange r;
        
        while ((r = [outString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound) {
            
            [outString deleteCharactersInRange:r];
        }
    }
    
    return outString;
}

- (NSString *)stringByStrippingHTML2  {
    
    NSMutableString *ms = [NSMutableString stringWithCapacity:[self length]];
    
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    NSString *s = nil;
    while (![scanner isAtEnd]) {
        
        [scanner scanUpToString:@"<" intoString:&s];
        if (s != nil)
            [ms appendString:s];
        
        [scanner scanUpToString:@">" intoString:NULL];
        if (![scanner isAtEnd])
            [scanner setScanLocation:[scanner scanLocation]+1];
        
        s = nil;
    }
    
    return ms;
}

- (NSString*)reverseString {
    
    NSInteger lengthOfString = [self length];
    
    NSMutableString *revStr = [NSMutableString stringWithCapacity:lengthOfString];
    
    while (lengthOfString > 0) {
        [revStr appendString:[NSString stringWithFormat:@"%c",[self characterAtIndex:--lengthOfString]]];
    }
    
    return revStr;
}

#pragma mark - Host
- (NSString*)domainNameFromUrlAddress {
    
    NSArray *first = [self componentsSeparatedByString:@"/"];
    for (NSString *part in first) {
        if ([part rangeOfString:@"."].location != NSNotFound){
            return part;
        }
    }
    
    return nil;
}

- (NSString*)hostNameFromUrlAddress {
    
    NSURL *url = [NSURL URLWithString:self];
    NSString *hostName = @"";
    if (url) {
        hostName = url.host;
    }
    
    return hostName;
}

- (NSString *)encodeURI {
    
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)decodeURI {
    
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)urlEncodeString {
    
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (CFStringRef)self,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8 ));
    
    return encodedString;
}

#pragma mark - Check
- (BOOL)containsString:(NSString *)string {
    
    return [self rangeOfString:string].location == NSNotFound ? NO : YES;
}

+ (BOOL)isValidEmail:(NSString *)email {
    
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *regex = stricterFilter ? stricterFilterString : laxString;
    return [self isValidString:email withRegex:regex];
}

+ (BOOL)isValidPhoneUS:(NSString *)phoneNumber {
    
    //NSString *regex = @"[0-9]{3}-[0-9]{3}-[0-9]{4}";
    //NSString *regex = @"^[0-9]\\d{2}-\\d{3}-\\d{4}$";
    NSString *regex = @"((\\(\\d{3}\\) ?)|(\\d{3}-))?\\d{3}-\\d{4}";
    
    //NSString *regex = @"\\(\\d{3}\\) \\d{3}-\\d{4}";
    return [self isValidString:phoneNumber withRegex:regex];
}

+ (BOOL)isValidPostalCodeUS:(NSString *)postalCode {
    // /^\d{5}(-\d{4})?$/ (12345; 12345-6789)
    // ^\d{5}(?:[-\s]\d{4})?$ (12345; 12345-6789; 12345 6789)
    
    NSString *regex = @"^([0-9]{5})(?:[-\\s]*([0-9]{4}))?$";
    return [self isValidString:postalCode withRegex:regex];
}

+ (BOOL)isValidPostalCode:(NSString *)postalCode countryCode:(NSString *)countryCode {
    
    NSString *regex = @"/^(?:[A-Z0-9]+([- ]?[A-Z0-9]+)*)?$";
    if ([countryCode isEqualToString:@"US"]) {
        regex = @"^([0-9]{5})(?:[-\\s]*([0-9]{4}))?$";
    }
    else if ([countryCode isEqualToString:@"CA"]) {
        regex = @"^([A-Z][0-9][A-Z])\\s*([0-9][A-Z][0-9])$";
    }
    
    return [self isValidString:postalCode withRegex:regex];
}

+ (BOOL)isNumber:(NSString *)number {
    
    NSString *regex = @"^\\d+$";
    //NSString *regex = @"^[0-9]+$";
    return [self isValidString:number withRegex:regex];
}

+ (BOOL)isNumberWithComma:(NSString *)number {
    
    NSString *regex = @"^\\d{1,3}([,]\\d{3})*$";
    return [self isValidString:number withRegex:regex];
}

+ (BOOL)isAlphabet:(NSString *)string {
    
    NSString *regex = @"^[a-zA-Z]+$";
    return [self isValidString:string withRegex:regex];
}

+ (BOOL)isAlphanumeric:(NSString *)string {
    
    NSString *regex = @"^[a-zA-Z0-9]+$";
    return [self isValidString:string withRegex:regex];
}

+ (BOOL)isValidURL:(NSString *)string {
    
    NSString *regex = @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    return [self isValidString:string withRegex:regex];
}

+ (BOOL)isValidString:(NSString *)string withRegex:(NSString *)regex {
    
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL matches = [test evaluateWithObject:string];
    return matches;
}

// Validate the input string with the given pattern and
// return the result as a boolean
+ (BOOL)validateString:(NSString *)string withPattern:(NSString *)pattern
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSAssert(regex, @"Unable to create regular expression");
    
    NSRange textRange = NSMakeRange(0, string.length);
    NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
    
    BOOL didValidate = NO;
    
    // Did we find a matching range
    if (matchRange.location != NSNotFound)
        didValidate = YES;
    
    return didValidate;
}

#pragma mark - Hashes
- (NSString *)md5 {
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

- (NSString *)sha1 {
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

- (NSString *)sha256 {
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

- (NSString *)sha512 {
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

- (NSData *)md5Data {
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(data.bytes, (CC_LONG)data.length, digest);
    
    NSData *output = [NSData dataWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
    
    return output;
}

- (NSData *)sha1Data {
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSData *output = [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    
    return output;
}

- (NSData *)sha256Data {
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, (CC_LONG)data.length, digest);
    
    NSData *output = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    
    return output;
}

- (NSData *)sha512Data {
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(data.bytes, (CC_LONG)data.length, digest);
    
    NSData *output = [NSData dataWithBytes:digest length:CC_SHA512_DIGEST_LENGTH];
    
    return output;
}

#pragma mark - Substring
- (NSString *)substringFrom:(NSInteger)from to:(NSInteger)to {
    
    NSString *rightPart = [self substringFromIndex:from];
    
    return [rightPart substringToIndex:to-from];
}

#pragma mark - Sign
+ (instancetype)centSign {
    return @"¢";
}

+ (instancetype)poundSign {
    return @"£";
}

+ (instancetype)currencySign {
    return @"¤";
}

+ (instancetype)yenSign {
    return @"¥";
}

+ (instancetype)brokenVerticalBar {
    return @"¦";
}

+ (instancetype)sectionSign {
    return @"§";
}

+ (instancetype)copyrightSign {
    return @"©";
}

+ (instancetype)registeredTradeMarkSign {
    return @"®";
}

+ (instancetype)degreeSign {
    return @"°";
}

+ (instancetype)plusOrMinusSign {
    return @"±";
}

+ (instancetype)microSign {
    return @"µ";
}

+ (instancetype)fractionOneQuarter {
    return @"¼";
}

+ (instancetype)fractionOneHalf {
    return @"½";
}

+ (instancetype)fractionThreeQuarters {
    return @"¾";
}

+ (instancetype)invertedQuestionMark {
    return @"¿";
}

+ (instancetype)euroSign {
    return @"€";
}

+ (instancetype)tradeMarkSign {
    return @"™";
}

+ (instancetype)perThousandSign {
    return @"‰";
}

+ (instancetype)bullet {
    return @"•";
}


@end
