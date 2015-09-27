//
//  UITextField+Shake.m
//  VIN API Project
//
//  Created by SonHD on 4/16/14.
//  Copyright (c) 2014 SonHD. All rights reserved.
//

#import "UITextField+Shake.h"

#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

#if !__has_feature(objc_instancetype)
#error This library requires instancetype
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//#error This library requires iOS 7.0 or higher
#endif

@implementation UITextField (Shake)


- (void)shake:(int)times withDelta:(CGFloat)delta
{
	[self _shake:times direction:1 currentTimes:0 withDelta:delta andSpeed:0.03 shakeDirection:ShakeDirectionHorizontal];
}

- (void)shake:(int)times withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval
{
	[self _shake:times direction:1 currentTimes:0 withDelta:delta andSpeed:interval shakeDirection:ShakeDirectionHorizontal];
}

- (void)shake:(int)times withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection
{
    [self _shake:times direction:1 currentTimes:0 withDelta:delta andSpeed:interval shakeDirection:shakeDirection];
}

- (void)_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection
{
	[UIView animateWithDuration:interval animations:^{
		self.transform = (shakeDirection == ShakeDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
	} completion:^(BOOL finished) {
		if(current >= times) {
			self.transform = CGAffineTransformIdentity;
			return;
		}
		[self _shake:(times - 1)
		   direction:direction * -1
		currentTimes:current + 1
		   withDelta:delta
			andSpeed:interval
      shakeDirection:shakeDirection];
	}];
}

@end
