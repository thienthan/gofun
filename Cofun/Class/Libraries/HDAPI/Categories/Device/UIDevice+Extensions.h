//
//  UIDevice+Extensions.h
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIDevicePlatform) {
    UIDeviceUnknown,
    
    UIDeviceSimulator,
    UIDeviceSimulatoriPhone,
    UIDeviceSimulatoriPad,
    UIDeviceSimulatorAppleTV,
    
    UIDevice1GiPhone,
    UIDevice3GiPhone,
    UIDevice3GSiPhone,
    UIDevice4iPhone,
    UIDevice4SiPhone,
    UIDevice5iPhone,
    
    UIDevice1GiPod,
    UIDevice2GiPod,
    UIDevice3GiPod,
    UIDevice4GiPod,
    
    UIDevice1GiPad,
    UIDevice2GiPad,
    UIDevice3GiPad,
    UIDevice4GiPad,
    
    UIDeviceAppleTV2,
    UIDeviceAppleTV3,
    UIDeviceAppleTV4,
    
    UIDeviceUnknowniPhone,
    UIDeviceUnknowniPod,
    UIDeviceUnknowniPad,
    UIDeviceUnknownAppleTV,
    UIDeviceIFPGA,
    
};

typedef NS_ENUM(NSInteger, UIDeviceFamily) {
    UIDeviceFamilyiPhone,
    UIDeviceFamilyiPod,
    UIDeviceFamilyiPad,
    UIDeviceFamilyAppleTV,
    UIDeviceFamilyUnknown,
    
};

@interface UIDevice (Extensions)


///---------------------------------------------------------------------------------------
/// Device
///---------------------------------------------------------------------------------------
- (NSString *) platform;
- (NSString *) hwmodel;
- (NSUInteger) platformType;
- (NSString *) platformString;

- (NSUInteger) cpuFrequency;
- (NSUInteger) busFrequency;
- (NSUInteger) cpuCount;
- (NSUInteger) totalMemory;
- (NSUInteger) userMemory;

- (NSNumber *) totalDiskSpace;
- (NSNumber *) freeDiskSpace;

- (NSString *) macaddress;

- (UIDevicePlatform) devicePlatform;
- (UIDeviceFamily) deviceFamily;

+ (BOOL) isRetinaDevice;
+ (BOOL) isPadDevice;
+ (BOOL) isPhoneDevice;
+ (BOOL) isPhone5Device;
+ (BOOL) isSimulatorDevice;
+ (BOOL) isMultiTaskingSupported;

+ (BOOL) checkLocationService;
+ (NSString *) UUID;
+ (float) version;

// name              // e.g. "My iPhone"
// model             // e.g. @"iPhone", @"iPod touch"
// localizedModel    // localized version of model
// systemName        // e.g. @"iOS"
// systemVersion     // e.g. @"4.0"


///-----------------------------------------------------------------
/// Ratio
///-----------------------------------------------------------------
+ (CGFloat)getRatioWidth;
+ (CGFloat)getRatioHeight;
+ (NSInteger)getRatioFontSize;
+ (NSInteger)getAdditionHeight;

///-----------------------------------------------------------------
/// Orientation
///-----------------------------------------------------------------
+ (BOOL)isLandscape;
+ (BOOL)isPortrait;

///-----------------------------------------------------------------
/// Screen Size
///-----------------------------------------------------------------
+ (CGRect)currentFrameWithInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
+ (CGRect)getCurrentFrame:(CGRect)frame withInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
+ (CGFloat)getStatusBarHeightWithInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

///-----------------------------------------------------------------
/// Flash
///-----------------------------------------------------------------
+ (BOOL)turnFlashTorch;
+ (void)turnFlashTorch:(BOOL)isOn;

@end
