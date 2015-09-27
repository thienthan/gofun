//
//  NSObject+Extensions.m
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

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

@implementation NSObject (Extensions)


#pragma mark - Convert
+ (CGFloat)degreesToRadians:(CGFloat)degrees {
    return degrees * M_PI / 180;
}

+ (CGFloat)radiansToDegrees:(CGFloat)radians {
    return radians * 180/M_PI;
}

#pragma mark - Check
+ (BOOL)isNull:(id)object {
    // Check if the object is nil or the NSNull object.
    
	if (object == nil || object == [NSNull null])
	{
		return YES;
	}
    
	return NO;
}

+ (BOOL)isNullOrEmpty:(id)object {
    // Check if the object is null or if the object responds to the length or count selector and is zero.
    
	if ([self isNull:object] == YES
		|| ([object respondsToSelector: @selector(length)]
			&& [object length] == 0)
		|| ([object respondsToSelector: @selector(count)]
			&& [object count] == 0))
	{
		return YES;
	}
    
	return NO;
}

#pragma mark - Perform Block
- (void)performBlock:(dispatch_block_t)block afterDelay:(NSTimeInterval)delay
{
	dispatch_time_t dispatchTime = dispatch_time(
                                                 DISPATCH_TIME_NOW,
                                                 delay * NSEC_PER_SEC);
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(
                                                             DISPATCH_QUEUE_PRIORITY_BACKGROUND,
                                                             0);
    
	dispatch_after(
                   dispatchTime,
                   globalQueue,
                   block);
}

- (void)performBlockOnMainThread:(dispatch_block_t)block
{
	dispatch_sync(
                  dispatch_get_main_queue(),
                  block);
}

- (void)performBlockInBackground:(dispatch_block_t)block
{
	dispatch_queue_t globalQueue = dispatch_get_global_queue(
                                                             DISPATCH_QUEUE_PRIORITY_BACKGROUND,
                                                             0);
    
	dispatch_async(
                   globalQueue,
                   block);
}


@end
