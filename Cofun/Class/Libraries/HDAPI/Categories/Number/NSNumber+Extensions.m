//
//  NSNumber+Extensions.m
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import "NSNumber+Extensions.h"

#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

#if !__has_feature(objc_instancetype)
#error This library requires instancetype
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//#error This library requires iOS 7.0 or higher
#endif

@implementation NSNumber (Extensions)

#pragma mark - Round
- (NSNumber *)floorNumber {
    
    return [NSNumber numberWithFloat:floor([self floatValue])];
}

- (NSNumber *)ceilNumber {
    
    return [NSNumber numberWithFloat:ceil([self floatValue])];
}

- (NSNumber *)roundNumber {
    
    return [NSNumber numberWithFloat:round(2 * [self floatValue]) / 2];
}

- (NSNumber *)roundCeilingNumberWithFractionDigits:(NSUInteger)number {
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:number];
    [formatter setRoundingMode:NSNumberFormatterRoundCeiling];
    
    NSString *numberString = [formatter stringFromNumber:self];
    
    return [NSNumber numberWithString:numberString];
}

- (NSNumber *)roundDownNumberWithFractionDigits:(NSUInteger)number {
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:number];
    [formatter setRoundingMode:NSNumberFormatterRoundDown];
    
    NSString *numberString = [formatter stringFromNumber:self];
    
    return [NSNumber numberWithString:numberString];
}

- (NSNumber *)roundFloorNumberWithFractionDigits:(NSUInteger)number {
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:number];
    [formatter setRoundingMode:NSNumberFormatterRoundFloor];
    
    NSString *numberString = [formatter stringFromNumber:self];
    
    return [NSNumber numberWithString:numberString];
}

- (NSNumber *)roundUpNumberWithFractionDigits:(NSUInteger)number {
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:number];
    [formatter setRoundingMode:NSNumberFormatterRoundUp];
    
    NSString *numberString = [formatter stringFromNumber:self];
    
    return [NSNumber numberWithString:numberString];
}

#pragma mark - Compare
- (BOOL)isLessThanNumber:(NSNumber *)number {
    
    return [self floatValue] < [number floatValue] ? YES : NO;
}

- (BOOL)isMoreThanNumber:(NSNumber *)number {
    
    return [self floatValue] > [number floatValue] ? YES : NO;
}

#pragma mark - NumberFromString
+ (instancetype)numberWithString:(NSString *)string {
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    return [formatter numberFromString:string];
}

@end
