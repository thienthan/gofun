//
//  NSMutableDictionary+Extensions.m
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import "NSMutableDictionary+Extensions.h"
#import "NSObject+Extensions.h"

#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

#if !__has_feature(objc_instancetype)
#error This library requires instancetype
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//#error This library requires iOS 7.0 or higher
#endif

@implementation NSMutableDictionary (Extensions)

#pragma mark - Init
- (instancetype)dictionaryWithXMLString:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *error;
    NSPropertyListFormat format;
    NSDictionary *dict = [NSPropertyListSerialization propertyListFromData:data
                                                          mutabilityOption:NSPropertyListMutableContainers
                                                                    format:&format
                                                          errorDescription:&error];
    return [NSMutableDictionary dictionaryWithDictionary:dict];
}

- (instancetype)dictionaryWithContentsOfXMLFile:(NSString *)filePath {
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSString *error;
    NSPropertyListFormat format;
    NSDictionary *dict = [NSPropertyListSerialization propertyListFromData:data
                                                          mutabilityOption:NSPropertyListMutableContainers
                                                                    format:&format
                                                          errorDescription:&error];
    return [NSMutableDictionary dictionaryWithDictionary:dict];
}

- (instancetype)dictionaryWithJSONString:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:&error];
    return [NSMutableDictionary dictionaryWithDictionary:dict];
}

- (NSString *)jsonStringWithPrettyPrint:(BOOL)prettyPrint {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:(NSJSONWritingOptions)    (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (! jsonData) {
        return @"";//return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

#pragma mark - Get
- (id)objectForKeyNotNull:(NSString *)key {
    if ([self containsObjectForKey:key]) {
        return [self objectForKey:key];
    }
    
    return nil;
}

- (NSInteger)intForKey:(NSString *)key {
    
    if ([self containsObjectForKey:key]) {
        return [[self objectForKey:key] integerValue];
    }
    
    return INT_MIN;
}

- (BOOL)boolForKey:(NSString *)key {
    
    if ([self containsObjectForKey:key]) {
        return [[self objectForKey:key] boolValue];
    }
    
    return NO;
}

- (float)floatForKey:(NSString *)key {
    
    if ([self containsObjectForKey:key]) {
        return [[self objectForKey:key] floatValue];
    }
    
    return FLT_MIN;
}

- (double)doubleForKey:(NSString *)key {
    
    if ([self containsObjectForKey:key]) {
        return [[self objectForKey:key] doubleValue];
    }
    
    return DBL_MIN;
}

- (long)longForKey:(NSString *)key {
    
    if ([self containsObjectForKey:key]) {
        return [[self objectForKey:key] longValue];
    }
    
    return LONG_MIN;
}

- (long long)longLongForKey:(NSString *)key {
    
    if ([self containsObjectForKey:key]) {
        return [[self objectForKey:key] longLongValue];
    }
    
    return LLONG_MIN;
}

- (NSString *)stringForKey:(NSString *)key {
    
    NSString *object = @"";
    if ([self containsObjectForKey:key]) {
        object = [[self objectForKey:key] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    
    return object;
}

- (CGPoint)pointForKey:(NSString *)key {
    
    CGPoint object = CGPointZero;
    if ([self containsObjectForKey:key]) {
        NSDictionary *dictionary = [self valueForKey:key];
        BOOL success = CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)dictionary, &object);
        
        if (success)
            return object;
        else
            return CGPointZero;
    }
    
    return object;
}

- (CGSize)sizeForKey:(NSString *)key {
    
    CGSize object = CGSizeZero;
    if ([self containsObjectForKey:key]) {
        NSDictionary *dictionary = [self valueForKey:key];
        BOOL success = CGSizeMakeWithDictionaryRepresentation((CFDictionaryRef)dictionary, &object);
        
        if (success)
            return object;
        else
            return CGSizeZero;
    }
    
    return object;
}

- (CGRect)rectForKey:(NSString *)key {
    
    CGRect object = CGRectZero;
    if ([self containsObjectForKey:key]) {
        NSDictionary *dictionary = [self valueForKey:key];
        BOOL success = CGRectMakeWithDictionaryRepresentation((CFDictionaryRef)dictionary, &object);
        
        if (success)
            return object;
        else
            return CGRectZero;
    }
    
    return object;
}

#pragma mark - Set
- (void)setInt:(NSInteger)object forKey:(NSString *)key {
    
    NSNumber *number = [NSNumber numberWithInteger:object];
    [self setObject:number forKey:key];
}

- (void)setBool:(BOOL)object forKey:(NSString *)key {
    
    NSNumber *number = [NSNumber numberWithBool:object];
    [self setObject:number forKey:key];
}

- (void)setFloat:(float)object forKey:(NSString *)key {
    
    NSNumber *number = [NSNumber numberWithFloat:object];
    [self setObject:number forKey:key];
}

- (void)setDouble:(double)object forKey:(NSString *)key {
    
    NSNumber *number = [NSNumber numberWithDouble:object];
    [self setObject:number forKey:key];
}

- (void)setLong:(long)object forKey:(NSString *)key {
    
    NSNumber *number = [NSNumber numberWithLong:object];
    [self setObject:number forKey:key];
}

- (void)setLongLong:(long long)object forKey:(NSString *)key {
    
    NSNumber *number = [NSNumber numberWithLongLong:object];
    [self setObject:number forKey:key];
}

- (void)setString:(NSString *)object forKey:(NSString *)key {
    
    if ([NSObject isNull:object] == YES)
    {
        object = @"";
    }
    [self setObject:object forKey:key];
}

- (void)setPoint:(CGPoint)object forKey:(NSString *)key {
    
    NSDictionary *dictionary = (NSDictionary *)CFBridgingRelease(CGPointCreateDictionaryRepresentation(object));
    [self setValue:dictionary forKey:key];
}

- (void)setSize:(CGSize)object forKey:(NSString *)key {
    
    NSDictionary *dictionary = (NSDictionary *)CFBridgingRelease(CGSizeCreateDictionaryRepresentation(object));
    [self setValue:dictionary forKey:key];
}

- (void)setRect:(CGRect)object forKey:(NSString *)key {
    
    NSDictionary *dictionary = (NSDictionary *)CFBridgingRelease(CGRectCreateDictionaryRepresentation(object));
    [self setValue:dictionary forKey:key];
}

#pragma mark - Check
- (BOOL)containsKey:(id)key {
    return [[self allKeys] containsObject:key];
}

- (BOOL)containsObjectForKey:(id)key {
    
    if ([self containsKey:key]) {
        if ([self objectForKey:key] != [NSNull null]){
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isNull:(NSMutableDictionary *)dictionary {
    
    if (dictionary == nil || [dictionary isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isNullOrEmpty:(NSMutableDictionary *)dictionary {
    
    if ([self isNull:dictionary] == NO && dictionary.count > 0) {
        return NO;
    }
    
    return YES;
}

#pragma mark - Query
+ (NSDictionary *)parseQueryString:(NSString *)query {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;
}

@end
