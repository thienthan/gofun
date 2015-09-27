//
//  UIDevice+Extension.h
//  FlimFlam
//
//  Created by SonHD on 10/9/14.
//  Copyright (c) 2014 SonHD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UIDeviceFamily) {
    UIDeviceFamilyiPhone,
    UIDeviceFamilyiPod,
    UIDeviceFamilyiPad,
    UIDeviceFamilyAppleTV,
    UIDeviceFamilyUnknown,
};

@interface UIDevice (Extension)

///-----------------------------------------------------------------
/// Hardware
///-----------------------------------------------------------------
/**
 Returns a machine-readable model name in the format of "iPhone4,1"
 */
- (NSString *)modelIdentifier;

/**
 Returns a human-readable model name in the format of "iPhone 4S". Fallback of the the `modelIdentifier` value.
 */
- (NSString *)modelName;

/**
 Returns the device family as a `UIDeviceFamily`
 */
- (UIDeviceFamily)deviceFamily;

///-----------------------------------------------------------------
/// 
///-----------------------------------------------------------------
+ (BOOL)isRetinaDisplay;
+ (BOOL)isPadDevice;
+ (BOOL)isPhoneDevice;
+ (BOOL)isIPhone4S;
+ (BOOL)isIPhone5;
+ (BOOL)isIPhone6;
+ (BOOL)isIPhone6Plus;
+ (BOOL)isRealDevice;
+ (BOOL)isSimulator;

+ (float)systemVersion;
+ (BOOL)checkLocationService;
+ (NSString *)UUID;

///---------------------------------------------------------------------------------------
///
///---------------------------------------------------------------------------------------
#pragma mark - Flash
+ (BOOL)turnFlashTorch;
+ (void)turnFlashTorch:(BOOL)isOn;

///---------------------------------------------------------------------------------------
/// Orientation
///---------------------------------------------------------------------------------------
#pragma mark - Orientation
+ (BOOL)isLandscape;
+ (BOOL)isPortrait;

@end
