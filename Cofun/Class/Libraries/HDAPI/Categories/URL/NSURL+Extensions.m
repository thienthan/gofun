//
//  NSURL+Extensions.m
//  VIN API Project
//
//  Created by SonHD on 1/28/14.
//  Copyright (c) 2014 SonHD. All rights reserved.
//

#import "NSURL+Extensions.h"

#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

#if !__has_feature(objc_instancetype)
#error This library requires instancetype
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//#error This library requires iOS 7.0 or higher
#endif

@implementation NSURL (Extensions)

- (NSDictionary *)getParameters {
	NSArray *pairs = [[self query] componentsSeparatedByString:@"&"];
	NSMutableDictionary *result = [NSMutableDictionary dictionary];
	for(NSString *pair in pairs) {
		NSArray *keyValue = [pair componentsSeparatedByString:@"="];
		if([keyValue count] > 1)
			[result setValue:[keyValue objectAtIndex:1]
					  forKey:[keyValue objectAtIndex:0]];
		else if([keyValue count] > 0)
			[result setValue:@"" forKey:[keyValue objectAtIndex:0]];
	}
	
	return result;
}

@end
