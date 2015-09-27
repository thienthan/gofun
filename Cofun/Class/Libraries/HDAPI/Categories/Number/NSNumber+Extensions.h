//
//  NSNumber+Extensions.h
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Extensions)

///-----------------------------------------------------------------
/// Round
///-----------------------------------------------------------------
- (NSNumber *)floorNumber;
- (NSNumber *)ceilNumber;
- (NSNumber *)roundNumber;

- (NSNumber *)roundCeilingNumberWithFractionDigits:(NSUInteger)number;
- (NSNumber *)roundDownNumberWithFractionDigits:(NSUInteger)number;
- (NSNumber *)roundFloorNumberWithFractionDigits:(NSUInteger)number;
- (NSNumber *)roundUpNumberWithFractionDigits:(NSUInteger)number;

///-----------------------------------------------------------------
/// Check
///-----------------------------------------------------------------
- (BOOL)isLessThanNumber:(NSNumber *)number;
- (BOOL)isMoreThanNumber:(NSNumber *)number;

+ (instancetype)numberWithString:(NSString *)string;

@end
