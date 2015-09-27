//
//  NSArray+Extensions.m
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import "NSArray+Extensions.h"

#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

#if !__has_feature(objc_instancetype)
#error This library requires instancetype
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//#error This library requires iOS 7.0 or higher
#endif

@implementation NSArray (Extensions)

#pragma mark - Accessing
- (id)firstObject {
    id firstObject = nil;
    
	if ([self count] > 0)
	{
		firstObject = [self objectAtIndex:0];
	}
    
	return firstObject;
}

- (id)lastObject {
    id lastObject = nil;
    
	if ([self count] > 0)
	{
		lastObject = [self objectAtIndex:[self count]-1];
	}
    
	return lastObject;
}

- (id)randomObject {
    id object = nil;
    
	if ([self count] > 0)
	{
		int randomIndex = arc4random() % [self count];
        
		object = [self objectAtIndex:randomIndex];
	}
    
	return object;
}

- (id)tryObjectAtIndex:(NSUInteger)index {
    id object = nil;
    
	if (index < [self count])
	{
		object = [self objectAtIndex:index];
	}
    
	return object;
}

#pragma mark - Sort array
- (NSMutableArray *)sortArrayWithColumnName:(NSString *)colName ascending:(BOOL)ascending{
    
    if ([colName isEqualToString:@""]) {
        colName = @"self";
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:colName ascending:ascending];
    
    NSArray *descriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    NSArray *sortedArray = [self sortedArrayUsingDescriptors:descriptors];
    
    return [NSMutableArray arrayWithArray:sortedArray];
}

#pragma mark - Filter array
- (NSMutableArray *)filterArrayWithAttributeName:(NSString *)attName attributeValue:(NSString *)attValue{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K == %@)", attName, attValue];
    
    NSArray *filteredArray = [self filteredArrayUsingPredicate:predicate];
    
    return [NSMutableArray arrayWithArray:filteredArray];
}

- (NSMutableArray *)filterArrayWithAttributeName:(NSString *)attName attributeValues:(NSArray *)attValues {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K IN %@)", attName, attValues];
    
    NSArray *filteredArray = [self filteredArrayUsingPredicate:predicate];
    
    return [NSMutableArray arrayWithArray:filteredArray];
}

#pragma mark - Reverse array
- (NSArray *)reversedArray {
	
    NSMutableArray *reversedArray = [NSMutableArray arrayWithCapacity:self.count];
    
    for (NSInteger i = 0; i < self.count; i++) {
        @autoreleasepool {
            id object = [self objectAtIndex:i];
            [reversedArray insertObject:object atIndex:0];
        }
    }
    
    return [NSArray arrayWithArray:reversedArray];
}

#pragma mark - Shuffle Array
- (NSArray *)shuffledArray {
    NSMutableArray *shuffledArray = [NSMutableArray arrayWithArray:self];
    for (NSUInteger i = [shuffledArray count] - 1; i > 0; i--) {
        [shuffledArray exchangeObjectAtIndex: arc4random() % (i+1) withObjectAtIndex: i];
    }
    
    return [NSArray arrayWithArray:shuffledArray];
}

#pragma mark - Check
+ (BOOL)isNull:(NSArray *)array {
    
    if (array == nil || [array isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isNullOrEmpty:(NSArray *)array {
    
    if ([self isNull:array] == NO && array.count > 0) {
        return NO;
    }
    
    return YES;
}

@end
