//
//  UIFont+Extensions.m
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import "UIFont+Extensions.h"

#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

#if !__has_feature(objc_instancetype)
#error This library requires instancetype
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//#error This library requires iOS 7.0 or higher
#endif

@implementation UIFont (Extensions)

+ (NSArray *)listFontFamilyName {
    
    // List all fonts on iPhone
    return [UIFont familyNames];
}

+ (NSArray *)listFontName {
    
    // List all fonts on iPhone
    NSArray *familyNames = [UIFont familyNames];
    NSMutableArray *fontNames = [NSMutableArray array];
    
    for (NSInteger i = 0; i < [familyNames count]; ++i)
    {
        @autoreleasepool {
            NSArray *fontNamesOfFamilyName = [UIFont fontNamesForFamilyName:[familyNames objectAtIndex:i]];
            
            [fontNames addObjectsFromArray:fontNamesOfFamilyName];
        }
    }
    
    return fontNames;
}


@end
