//
//  NSMutableDictionary+Extensions.h
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface NSMutableDictionary (Extensions)

///-----------------------------------------------------------------
/// Init
///-----------------------------------------------------------------
- (instancetype)dictionaryWithXMLString:(NSString *)string;
- (instancetype)dictionaryWithContentsOfXMLFile:(NSString *)filePath;
- (instancetype)dictionaryWithJSONString:(NSString *)string;
- (NSString *)jsonStringWithPrettyPrint:(BOOL)prettyPrint;

///-----------------------------------------------------------------
/// Get
///-----------------------------------------------------------------
- (id)objectForKeyNotNull:(NSString *)key;
- (NSInteger)intForKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key;
- (float)floatForKey:(NSString *)key;
- (double)doubleForKey:(NSString *)key;
- (long)longForKey:(NSString *)key;
- (long long)longLongForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;

- (CGPoint)pointForKey:(NSString *)key;
- (CGSize)sizeForKey:(NSString *)key;
- (CGRect)rectForKey:(NSString *)key;

///-----------------------------------------------------------------
/// Set
///-----------------------------------------------------------------
- (void)setInt:(NSInteger)object forKey:(NSString *)key;
- (void)setBool:(BOOL)object forKey:(NSString *)key;
- (void)setFloat:(float)object forKey:(NSString *)key;
- (void)setDouble:(double)object forKey:(NSString *)key;
- (void)setLong:(long)object forKey:(NSString *)key;
- (void)setLongLong:(long long)object forKey:(NSString *)key;
- (void)setString:(NSString *)object forKey:(NSString *)key;

- (void)setPoint:(CGPoint)object forKey:(NSString *)key;
- (void)setSize:(CGSize)object forKey:(NSString *)key;
- (void)setRect:(CGRect)object forKey:(NSString *)key;

///-----------------------------------------------------------------
/// Check
///-----------------------------------------------------------------
- (BOOL)containsKey:(id)key;
- (BOOL)containsObjectForKey:(id)key;
+ (BOOL)isNull:(NSMutableDictionary *)dictionary;
+ (BOOL)isNullOrEmpty:(NSMutableDictionary *)dictionary;

///-----------------------------------------------------------------
/// Query
///-----------------------------------------------------------------
+ (NSDictionary *)parseQueryString:(NSString *)query;

@end
