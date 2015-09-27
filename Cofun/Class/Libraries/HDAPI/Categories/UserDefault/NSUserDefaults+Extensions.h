//
//  NSUserDefaults+Extensions.h
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Extensions)

+ (BOOL)containKey:(NSString*)key;
+ (void)deleteObjectWithKey:(NSString*)key;

+ (id)objectForKey:(NSString*)key andSubKey:(NSString*)subKey;

+ (id)objectForKey:(NSString*)key;
+ (void)setObject:(id)object forKey:(NSString*)key;

+ (id)objectClassForKey:(NSString*)key;
+ (void)setObjectClass:(id)object forKey:(NSString*)key;

@end
