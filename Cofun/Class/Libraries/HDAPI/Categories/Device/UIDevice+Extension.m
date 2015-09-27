//
//  UIDevice+Extension.m
//  FlimFlam
//
//  Created by SonHD on 10/9/14.
//  Copyright (c) 2014 SonHD. All rights reserved.
//

#import "UIDevice+Extension.h"
#include <sys/sysctl.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <CoreLocation/CoreLocation.h>

@implementation UIDevice (Extension)

///-----------------------------------------------------------------
/// Hardware
///-----------------------------------------------------------------
- (NSString *)getSysInfoByName:(char *)typeSpecifier
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    return results;
}

- (NSString *)modelIdentifier
{
    return [self getSysInfoByName:"hw.machine"];
}

- (NSString *)modelName
{
    return [self modelNameForModelIdentifier:[self modelIdentifier]];
}

- (NSString *)modelNameForModelIdentifier:(NSString *)modelIdentifier
{
    // iPhone http://theiphonewiki.com/wiki/IPhone
    
    if ([modelIdentifier isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([modelIdentifier isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([modelIdentifier isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([modelIdentifier isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([modelIdentifier isEqualToString:@"iPhone3,2"])    return @"iPhone 4 (GSM Rev A)";
    if ([modelIdentifier isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([modelIdentifier isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([modelIdentifier isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([modelIdentifier isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (Global)";
    if ([modelIdentifier isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([modelIdentifier isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (Global)";
    if ([modelIdentifier isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([modelIdentifier isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (Global)";
    if ([modelIdentifier isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([modelIdentifier isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    
    // iPad http://theiphonewiki.com/wiki/IPad
    
    if ([modelIdentifier isEqualToString:@"iPad1,1"])      return @"iPad 1G";
    if ([modelIdentifier isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([modelIdentifier isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([modelIdentifier isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([modelIdentifier isEqualToString:@"iPad2,4"])      return @"iPad 2 (Rev A)";
    if ([modelIdentifier isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([modelIdentifier isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM)";
    if ([modelIdentifier isEqualToString:@"iPad3,3"])      return @"iPad 3 (Global)";
    if ([modelIdentifier isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([modelIdentifier isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([modelIdentifier isEqualToString:@"iPad3,6"])      return @"iPad 4 (Global)";
    
    if ([modelIdentifier isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([modelIdentifier isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    
    // iPad Mini http://theiphonewiki.com/wiki/IPad_mini
    
    if ([modelIdentifier isEqualToString:@"iPad2,5"])      return @"iPad mini 1G (WiFi)";
    if ([modelIdentifier isEqualToString:@"iPad2,6"])      return @"iPad mini 1G (GSM)";
    if ([modelIdentifier isEqualToString:@"iPad2,7"])      return @"iPad mini 1G (Global)";
    if ([modelIdentifier isEqualToString:@"iPad4,4"])      return @"iPad mini 2G (WiFi)";
    if ([modelIdentifier isEqualToString:@"iPad4,5"])      return @"iPad mini 2G (Cellular)";
    
    // iPod http://theiphonewiki.com/wiki/IPod
    
    if ([modelIdentifier isEqualToString:@"iPod1,1"])      return @"iPod touch 1G";
    if ([modelIdentifier isEqualToString:@"iPod2,1"])      return @"iPod touch 2G";
    if ([modelIdentifier isEqualToString:@"iPod3,1"])      return @"iPod touch 3G";
    if ([modelIdentifier isEqualToString:@"iPod4,1"])      return @"iPod touch 4G";
    if ([modelIdentifier isEqualToString:@"iPod5,1"])      return @"iPod touch 5G";
    
    // Apple TV http://theiphonewiki.com/wiki/Apple_TV
    
    if ([modelIdentifier isEqualToString:@"AppleTV1,1"])   return @"Apple TV";
    if ([modelIdentifier isEqualToString:@"AppleTV2,1"])   return @"Apple TV 2G";
    if ([modelIdentifier isEqualToString:@"AppleTV3,1"])   return @"Apple TV 3G (32nm)";
    if ([modelIdentifier isEqualToString:@"AppleTV3,2"])   return @"Apple TV 3G (28nm)";
    
    // Simulator
    if ([modelIdentifier hasSuffix:@"86"] || [modelIdentifier isEqual:@"x86_64"])
    {
        BOOL smallerScreen = ([[UIScreen mainScreen] bounds].size.width < 768.0);
        return (smallerScreen ? @"iPhone Simulator" : @"iPad Simulator");
    }
    
    return modelIdentifier;
}

- (UIDeviceFamily) deviceFamily
{
    NSString *modelIdentifier = [self modelIdentifier];
    if ([modelIdentifier hasPrefix:@"iPhone"]) return UIDeviceFamilyiPhone;
    if ([modelIdentifier hasPrefix:@"iPod"]) return UIDeviceFamilyiPod;
    if ([modelIdentifier hasPrefix:@"iPad"]) return UIDeviceFamilyiPad;
    if ([modelIdentifier hasPrefix:@"AppleTV"]) return UIDeviceFamilyAppleTV;
    return UIDeviceFamilyUnknown;
}

///-----------------------------------------------------------------
///
///-----------------------------------------------------------------
+ (BOOL)isRetinaDisplay {
    return ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] >= 2);
}

+ (BOOL)isPadDevice {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

+ (BOOL)isPhoneDevice {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

+ (BOOL)isIPhone4S {
    // 320 x 480 (640 x 960)
    return ([UIScreen mainScreen].bounds.size.height == 480.0f);
}

+ (BOOL)isIPhone5 {
    // 320 x 568 (640 x 1136)
    return ([UIScreen mainScreen].bounds.size.height == 568.0f);
}

+ (BOOL)isIPhone6 {
    // 375 x 667 (750 x 1334)
    return ([UIScreen mainScreen].bounds.size.height == 667.0f);
}

+ (BOOL)isIPhone6Plus {
    // 414 x 736 (1242 x 2208) @3x
    return ([UIScreen mainScreen].bounds.size.height == 736.0f);
}

+ (BOOL)isRealDevice {
#if TARGET_IPHONE_SIMULATOR
    return NO; // simulator
#elif TARGET_OS_IPHONE
    return YES; // device
#else
    return NO; // unknown
#endif
}

+ (BOOL)isSimulator {
#if TARGET_IPHONE_SIMULATOR
    return YES; // simulator
#elif TARGET_OS_IPHONE
    return NO; // device
#else
    return NO; // unknown
#endif
}

+ (NSString *)UUID {
    NSString *uuid = @"";
    if ([[self currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        uuid = [[[self currentDevice]identifierForVendor]UUIDString];
    }
    else {
        CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
        uuid = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, newUniqueId));
        
        CFRelease(newUniqueId);
    }
    return uuid;
}

+ (float)systemVersion {
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (BOOL)checkLocationService {
    BOOL locationServicesEnabled = [CLLocationManager locationServicesEnabled];
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    
    if (locationServicesEnabled == NO){
        
        NSLog(@"Location Services is required for this application. Please enable Location Services");
    }
    else{
        if (authorizationStatus == kCLAuthorizationStatusRestricted) {
            NSLog(@"kCLAuthorizationStatusRestricted");
        }
        else if (authorizationStatus == kCLAuthorizationStatusNotDetermined) {
            NSLog(@"kCLAuthorizationStatusNotDetermined");
        }
        else if (authorizationStatus == kCLAuthorizationStatusDenied) {
            NSLog(@"kCLAuthorizationStatusDenied");
        }
        else if (authorizationStatus == kCLAuthorizationStatusAuthorized) {
            NSLog(@"kCLAuthorizationStatusAuthorized");
            return YES;
        }
    }
    return NO;
}

///---------------------------------------------------------------------------------------
///
///---------------------------------------------------------------------------------------
#pragma mark - Flash
+ (BOOL)turnFlashTorch {
    
    BOOL isOn = NO;
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            [device lockForConfiguration:nil];
            if ([device isTorchActive] || [device isFlashActive]) {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            else{
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                isOn = YES;
            }
            [device unlockForConfiguration];
        }
    }
    
    return isOn;
}

+ (void)turnFlashTorch:(BOOL)isOn {
    
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            [device lockForConfiguration:nil];
            if (isOn) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
            }
            else{
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
            }
            [device unlockForConfiguration];
        }
    }
}

///---------------------------------------------------------------------------------------
///
///---------------------------------------------------------------------------------------
+ (BOOL)isLandscape {
    
    return UIDeviceOrientationIsLandscape([[self currentDevice] orientation]);
}

+ (BOOL)isPortrait {
    
    return UIDeviceOrientationIsPortrait([[self currentDevice] orientation]);
}

@end
