//
//  NSUserDefaults+Extensions.m
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import "NSUserDefaults+Extensions.h"

#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

#if !__has_feature(objc_instancetype)
#error This library requires instancetype
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//#error This library requires iOS 7.0 or higher
#endif

@implementation NSUserDefaults (Extensions)

+ (BOOL)containKey:(NSString*)key {
    
    if (key) {
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        if ([userDefault objectForKey:key] != nil) {
            
            return YES;
        }
    }
    return NO;
}

+ (void)deleteObjectWithKey:(NSString*)key {
    
    if (key) {
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        if ([userDefault objectForKey:key] != nil) {
            
            [userDefault removeObjectForKey:key];
            [userDefault synchronize];
        }
    }
}

+ (id)objectForKey:(NSString*)key andSubKey:(NSString*)subKey {
    
    if (key && subKey) {
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        if ([userDefault objectForKey:key] != nil) {
            
            return [[userDefault objectForKey:key] objectForKey:subKey];
        }
    }
    return nil;
}

+ (id)objectForKey:(NSString*)key {
    
    if (key) {
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        return [userDefault objectForKey:key];
    }
    return nil;
}

+ (void)setObject:(id)object forKey:(NSString*)key {
    
    if (key && object) {
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:object forKey:key];
        [userDefault synchronize];
    }
}

+ (void)setObjectClass:(id)object forKey:(NSString*)key {
    
    if (key && object) {
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        //C1:
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
        [userDefault setObject:data forKey:key];
        [userDefault synchronize];
        
        //C2:
        /*
         NSMutableData *data = [[NSMutableData alloc] init];
         NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
         [archiver encodeObject:object forKey:[NSString stringWithFormat:@"archiver_%@",key]];
         [archiver finishEncoding];
         [archiver release];
         
         [userDefault setObject:data forKey:key];
         [data release];
         
         [userDefault synchronize];
         */
    }
}

+ (id)objectClassForKey:(NSString*)key {
    
    if (key) {
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        if ([userDefault objectForKey:key] != nil) {
            
            //C1:
            
            NSData *data = [userDefault objectForKey:key];
            return [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            
            //C2:
            /*
             NSData *data = [userDefault objectForKey:key];
             NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
             
             id object = [unarchiver decodeObjectForKey:[NSString stringWithFormat:@"archiver_%@",key]];
             [unarchiver finishDecoding];
             [unarchiver release];
             return object;
             */
        }
    }
    return nil;
}

@end
