//
//  NSObject+Extensions.h
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface NSObject (Extensions)

///-----------------------------------------------------------------
/// Convert
///-----------------------------------------------------------------
+ (CGFloat)degreesToRadians:(CGFloat)degrees;
+ (CGFloat)radiansToDegrees:(CGFloat)radians;

///-----------------------------------------------------------------
/// Check
///-----------------------------------------------------------------
+ (BOOL)isNull:(id)object;
+ (BOOL)isNullOrEmpty:(id)object;

///-----------------------------------------------------------------
/// Perform Block
///-----------------------------------------------------------------
- (void)performBlock:(dispatch_block_t)block afterDelay:(NSTimeInterval)delay;
- (void)performBlockOnMainThread:(dispatch_block_t)block;
- (void)performBlockInBackground:(dispatch_block_t)block;

@end
