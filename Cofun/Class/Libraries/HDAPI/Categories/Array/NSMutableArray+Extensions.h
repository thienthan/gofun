//
//  NSMutableArray+Extensions.h
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Extensions)

///-----------------------------------------------------------------
/// Accessing
///-----------------------------------------------------------------
- (id)firstObject;
- (id)lastObject;
- (id)randomObject;
- (id)tryObjectAtIndex:(NSUInteger)index;


///-----------------------------------------------------------------
/// Sort - Filter - Shuffle
///-----------------------------------------------------------------
- (NSMutableArray *)sortArrayWithColumnName:(NSString *)colName ascending:(BOOL)ascending;
- (NSMutableArray *)filterArrayWithAttributeName:(NSString *)attName attributeValue:(NSString *)attValue;
- (NSMutableArray *)filterArrayWithAttributeName:(NSString *)attName attributeValues:(NSArray *)attValues;

- (void)reverse;//change self
- (NSMutableArray *)reversedArray;

- (void)shuffle;//change self
- (NSMutableArray*)shuffledArray;

+ (BOOL)isNull:(NSMutableArray *)array;
+ (BOOL)isNullOrEmpty:(NSMutableArray *)array;

@end
