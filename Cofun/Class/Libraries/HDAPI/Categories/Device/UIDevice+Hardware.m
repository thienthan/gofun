//
//  UIDevice+Hardware.m
//  VIN API Project
//
//  Created by SonHD on 1/24/14.
//  Copyright (c) 2014 SonHD. All rights reserved.
//

#import "UIDevice+Hardware.h"

#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

#if !__has_feature(objc_instancetype)
#error This library requires instancetype
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//#error This library requires iOS 7.0 or higher
#endif

#define kLSRatioWidth 768.0f/320.0f
#define kLSRatioHeight 1004.0f/460.0f

#include <sys/types.h>
#include <sys/sysctl.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>

@implementation UIDevice (Hardware)

- (NSString*)hardwareString {
    size_t size = 100;
    char *hw_machine = malloc(size);
    int name[] = {CTL_HW,HW_MACHINE};
    sysctl(name, 2, hw_machine, &size, NULL, 0);
    NSString *hardware = [NSString stringWithUTF8String:hw_machine];
    free(hw_machine);
    return hardware;
}

/* This is another way of gtting the system info
 * For this you have to #import <sys/utsname.h>
 */

/*
 NSString* machineName
 {
 struct utsname systemInfo;
 uname(&systemInfo);
 return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
 }
 */

- (Hardware)hardware {
    NSString *hardware = [self hardwareString];
    if ([hardware isEqualToString:@"iPhone1,1"])    return IPHONE_2G;
    if ([hardware isEqualToString:@"iPhone1,2"])    return IPHONE_3G;
    if ([hardware isEqualToString:@"iPhone2,1"])    return IPHONE_3GS;
    if ([hardware isEqualToString:@"iPhone3,1"])    return IPHONE_4;
    if ([hardware isEqualToString:@"iPhone3,2"])    return IPHONE_4;
    if ([hardware isEqualToString:@"iPhone3,3"])    return IPHONE_4_CDMA;
    if ([hardware isEqualToString:@"iPhone4,1"])    return IPHONE_4S;
    if ([hardware isEqualToString:@"iPhone5,1"])    return IPHONE_5;
    if ([hardware isEqualToString:@"iPhone5,2"])    return IPHONE_5_CDMA_GSM;
    if ([hardware isEqualToString:@"iPhone5,3"])    return IPHONE_5C;
    if ([hardware isEqualToString:@"iPhone5,4"])    return IPHONE_5C_CDMA_GSM;
    if ([hardware isEqualToString:@"iPhone6,1"])    return IPHONE_5S;
    if ([hardware isEqualToString:@"iPhone6,2"])    return IPHONE_5S_CDMA_GSM;
    
    if ([hardware isEqualToString:@"iPod1,1"])      return IPOD_TOUCH_1G;
    if ([hardware isEqualToString:@"iPod2,1"])      return IPOD_TOUCH_2G;
    if ([hardware isEqualToString:@"iPod3,1"])      return IPOD_TOUCH_3G;
    if ([hardware isEqualToString:@"iPod4,1"])      return IPOD_TOUCH_4G;
    if ([hardware isEqualToString:@"iPod5,1"])      return IPOD_TOUCH_5G;
    
    if ([hardware isEqualToString:@"iPad1,1"])      return IPAD;
    if ([hardware isEqualToString:@"iPad1,2"])      return IPAD_3G;
    if ([hardware isEqualToString:@"iPad2,1"])      return IPAD_2_WIFI;
    if ([hardware isEqualToString:@"iPad2,2"])      return IPAD_2;
    if ([hardware isEqualToString:@"iPad2,3"])      return IPAD_2_CDMA;
    if ([hardware isEqualToString:@"iPad2,4"])      return IPAD_2;
    if ([hardware isEqualToString:@"iPad2,5"])      return IPAD_MINI_WIFI;
    if ([hardware isEqualToString:@"iPad2,6"])      return IPAD_MINI;
    if ([hardware isEqualToString:@"iPad2,7"])      return IPAD_MINI_WIFI_CDMA;
    if ([hardware isEqualToString:@"iPad3,1"])      return IPAD_3_WIFI;
    if ([hardware isEqualToString:@"iPad3,2"])      return IPAD_3_WIFI_CDMA;
    if ([hardware isEqualToString:@"iPad3,3"])      return IPAD_3;
    if ([hardware isEqualToString:@"iPad3,4"])      return IPAD_4_WIFI;
    if ([hardware isEqualToString:@"iPad3,5"])      return IPAD_4;
    if ([hardware isEqualToString:@"iPad3,6"])      return IPAD_4_GSM_CDMA;
    if ([hardware isEqualToString:@"iPad4,1"])      return IPAD_AIR_WIFI;
    if ([hardware isEqualToString:@"iPad4,2"])      return IPAD_AIR_WIFI_GSM;
    if ([hardware isEqualToString:@"iPad4,3"])      return IPAD_AIR_WIFI_CDMA;
    if ([hardware isEqualToString:@"iPad4,4"])      return IPAD_MINI_RETINA_WIFI;
    if ([hardware isEqualToString:@"iPad4,5"])      return IPAD_MINI_RETINA_WIFI_CDMA;
    
    if ([hardware isEqualToString:@"i386"])         return SIMULATOR;
    if ([hardware isEqualToString:@"x86_64"])       return SIMULATOR;
    return NOT_AVAILABLE;
}

- (HardwareType)hardwareType {
    NSString *hardware = [self hardwareString];
    if ([hardware isEqualToString:@"iPhone1,1"])    return IPHONE_TYPE;
    if ([hardware isEqualToString:@"iPhone1,2"])    return IPHONE_TYPE;
    if ([hardware isEqualToString:@"iPhone2,1"])    return IPHONE_TYPE;
    if ([hardware isEqualToString:@"iPhone3,1"])    return IPHONE_TYPE;
    if ([hardware isEqualToString:@"iPhone3,2"])    return IPHONE_TYPE;
    if ([hardware isEqualToString:@"iPhone3,3"])    return IPHONE_TYPE;
    if ([hardware isEqualToString:@"iPhone4,1"])    return IPHONE_TYPE;
    if ([hardware isEqualToString:@"iPhone5,1"])    return IPHONE_TYPE;
    if ([hardware isEqualToString:@"iPhone5,2"])    return IPHONE_TYPE;
    if ([hardware isEqualToString:@"iPhone5,3"])    return IPHONE_TYPE;
    if ([hardware isEqualToString:@"iPhone5,4"])    return IPHONE_TYPE;
    if ([hardware isEqualToString:@"iPhone6,1"])    return IPHONE_TYPE;
    if ([hardware isEqualToString:@"iPhone6,2"])    return IPHONE_TYPE;
    
    if ([hardware isEqualToString:@"iPod1,1"])      return IPOD_TOUCH_TYPE;
    if ([hardware isEqualToString:@"iPod2,1"])      return IPOD_TOUCH_TYPE;
    if ([hardware isEqualToString:@"iPod3,1"])      return IPOD_TOUCH_TYPE;
    if ([hardware isEqualToString:@"iPod4,1"])      return IPOD_TOUCH_TYPE;
    if ([hardware isEqualToString:@"iPod5,1"])      return IPOD_TOUCH_TYPE;
    
    if ([hardware isEqualToString:@"iPad1,1"])      return IPAD_TYPE;
    if ([hardware isEqualToString:@"iPad1,2"])      return IPAD_TYPE;
    if ([hardware isEqualToString:@"iPad2,1"])      return IPAD_TYPE;
    if ([hardware isEqualToString:@"iPad2,2"])      return IPAD_TYPE;
    if ([hardware isEqualToString:@"iPad2,3"])      return IPAD_TYPE;
    if ([hardware isEqualToString:@"iPad2,4"])      return IPAD_TYPE;
    if ([hardware isEqualToString:@"iPad2,5"])      return IPAD_MINI_TYPE;
    if ([hardware isEqualToString:@"iPad2,6"])      return IPAD_MINI_TYPE;
    if ([hardware isEqualToString:@"iPad2,7"])      return IPAD_MINI_TYPE;
    if ([hardware isEqualToString:@"iPad3,1"])      return IPAD_TYPE;
    if ([hardware isEqualToString:@"iPad3,2"])      return IPAD_TYPE;
    if ([hardware isEqualToString:@"iPad3,3"])      return IPAD_TYPE;
    if ([hardware isEqualToString:@"iPad3,4"])      return IPAD_TYPE;
    if ([hardware isEqualToString:@"iPad3,5"])      return IPAD_TYPE;
    if ([hardware isEqualToString:@"iPad3,6"])      return IPAD_TYPE;
    if ([hardware isEqualToString:@"iPad4,1"])      return IPAD_TYPE;
    if ([hardware isEqualToString:@"iPad4,2"])      return IPAD_TYPE;
    if ([hardware isEqualToString:@"iPad4,3"])      return IPAD_TYPE;
    if ([hardware isEqualToString:@"iPad4,4"])      return IPAD_MINI_TYPE;
    if ([hardware isEqualToString:@"iPad4,5"])      return IPAD_MINI_TYPE;
    
    if ([hardware isEqualToString:@"i386"])         return SIMULATOR_TYPE;
    if ([hardware isEqualToString:@"x86_64"])       return SIMULATOR_TYPE;
    
    if ([hardware hasPrefix:@"iPhone"]) return IPHONE_TYPE;
    if ([hardware hasPrefix:@"iPod"]) return IPOD_TOUCH_TYPE;
    if ([hardware hasPrefix:@"iPad"]) return IPAD_TYPE;
    
    return NOT_AVAILABLE_TYPE;
}

- (NSString*)hardwareDescription {
    NSString *hardware = [self hardwareString];
    if ([hardware isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([hardware isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([hardware isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([hardware isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([hardware isEqualToString:@"iPhone3,2"])    return @"iPhone 4 (GSM Rev. A)";
    if ([hardware isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([hardware isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([hardware isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([hardware isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (Global)";
    if ([hardware isEqualToString:@"iPhone5,3"])    return @"iPhone 5C (GSM)";
    if ([hardware isEqualToString:@"iPhone5,4"])    return @"iPhone 5C (Global)";
    if ([hardware isEqualToString:@"iPhone6,1"])    return @"iPhone 5S (GSM)";
    if ([hardware isEqualToString:@"iPhone6,2"])    return @"iPhone 5S (Global)";
    
    if ([hardware isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
    if ([hardware isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
    if ([hardware isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
    if ([hardware isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
    if ([hardware isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([hardware isEqualToString:@"iPad1,1"])      return @"iPad (WiFi)";
    if ([hardware isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([hardware isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([hardware isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([hardware isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([hardware isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi Rev. A)";
    if ([hardware isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([hardware isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([hardware isEqualToString:@"iPad2,7"])      return @"iPad Mini (CDMA)";
    if ([hardware isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([hardware isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
    if ([hardware isEqualToString:@"iPad3,3"])      return @"iPad 3 (Global)";
    if ([hardware isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([hardware isEqualToString:@"iPad3,5"])      return @"iPad 4 (CDMA)";
    if ([hardware isEqualToString:@"iPad3,6"])      return @"iPad 4 (Global)";
    if ([hardware isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([hardware isEqualToString:@"iPad4,2"])      return @"iPad Air (WiFi+GSM)";
    if ([hardware isEqualToString:@"iPad4,3"])      return @"iPad Air (WiFi+CDMA)";
    if ([hardware isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina (WiFi)";
    if ([hardware isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina (WiFi+CDMA)";
    if ([hardware isEqualToString:@"i386"])         return @"Simulator";
    if ([hardware isEqualToString:@"x86_64"])       return @"Simulator";
    
    NSLog(@"This is a device which is not listed in this category. Please visit https://github.com/inderkumarrathore/UIDevice-Hardware and add a comment there.");
    NSLog(@"Your device hardware string is: %@", hardware);
    if ([hardware hasPrefix:@"iPhone"]) return @"iPhone";
    if ([hardware hasPrefix:@"iPod"]) return @"iPod";
    if ([hardware hasPrefix:@"iPad"]) return @"iPad";
    return nil;
}

- (NSString*)hardwareSimpleDescription
{
    NSString *hardware = [self hardwareString];
    if ([hardware isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([hardware isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([hardware isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([hardware isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([hardware isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([hardware isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([hardware isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([hardware isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([hardware isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([hardware isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([hardware isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([hardware isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([hardware isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    
    if ([hardware isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
    if ([hardware isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
    if ([hardware isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
    if ([hardware isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
    if ([hardware isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([hardware isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([hardware isEqualToString:@"iPad1,2"])      return @"iPad";
    if ([hardware isEqualToString:@"iPad2,1"])      return @"iPad 2";
    if ([hardware isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([hardware isEqualToString:@"iPad2,3"])      return @"iPad 2";
    if ([hardware isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([hardware isEqualToString:@"iPad2,5"])      return @"iPad Mini";
    if ([hardware isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([hardware isEqualToString:@"iPad2,7"])      return @"iPad Mini";
    if ([hardware isEqualToString:@"iPad3,1"])      return @"iPad 3";
    if ([hardware isEqualToString:@"iPad3,2"])      return @"iPad 3";
    if ([hardware isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([hardware isEqualToString:@"iPad3,4"])      return @"iPad 4";
    if ([hardware isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([hardware isEqualToString:@"iPad3,6"])      return @"iPad 4";
    if ([hardware isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([hardware isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([hardware isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([hardware isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina";
    if ([hardware isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina";
    
    if ([hardware isEqualToString:@"i386"])         return @"Simulator";
    if ([hardware isEqualToString:@"x86_64"])       return @"Simulator";
    
    NSLog(@"This is a device which is not listed in this category. Please visit https://github.com/inderkumarrathore/UIDevice-Hardware and add a comment there.");
    NSLog(@"Your device hardware string is: %@", hardware);
    
    if ([hardware hasPrefix:@"iPhone"]) return @"iPhone";
    if ([hardware hasPrefix:@"iPod"]) return @"iPod";
    if ([hardware hasPrefix:@"iPad"]) return @"iPad";
    
    return nil;
}

- (float)hardwareNumber {
    NSString *hardware = [self hardwareString];
    if ([hardware isEqualToString:@"iPhone1,1"])    return 1.1f;
    if ([hardware isEqualToString:@"iPhone1,2"])    return 1.2f;
    if ([hardware isEqualToString:@"iPhone2,1"])    return 2.1f;
    if ([hardware isEqualToString:@"iPhone3,1"])    return 3.1f;
    if ([hardware isEqualToString:@"iPhone3,2"])    return 3.2f;
    if ([hardware isEqualToString:@"iPhone3,3"])    return 3.3f;
    if ([hardware isEqualToString:@"iPhone4,1"])    return 4.1f;
    if ([hardware isEqualToString:@"iPhone5,1"])    return 5.1f;
    if ([hardware isEqualToString:@"iPhone5,2"])    return 5.2f;
    if ([hardware isEqualToString:@"iPhone5,3"])    return 5.3f;
    if ([hardware isEqualToString:@"iPhone5,4"])    return 5.4f;
    if ([hardware isEqualToString:@"iPhone6,1"])    return 6.1f;
    if ([hardware isEqualToString:@"iPhone6,2"])    return 6.2f;
    
    if ([hardware isEqualToString:@"iPod1,1"])      return 1.1f;
    if ([hardware isEqualToString:@"iPod2,1"])      return 2.1f;
    if ([hardware isEqualToString:@"iPod3,1"])      return 3.1f;
    if ([hardware isEqualToString:@"iPod4,1"])      return 4.1f;
    if ([hardware isEqualToString:@"iPod5,1"])      return 5.1f;
    
    if ([hardware isEqualToString:@"iPad1,1"])      return 1.1f;
    if ([hardware isEqualToString:@"iPad1,2"])      return 1.2f;
    if ([hardware isEqualToString:@"iPad2,1"])      return 2.1f;
    if ([hardware isEqualToString:@"iPad2,2"])      return 2.2f;
    if ([hardware isEqualToString:@"iPad2,3"])      return 2.3f;
    if ([hardware isEqualToString:@"iPad2,4"])      return 2.4f;
    if ([hardware isEqualToString:@"iPad2,5"])      return 2.5f;
    if ([hardware isEqualToString:@"iPad2,6"])      return 2.6f;
    if ([hardware isEqualToString:@"iPad2,7"])      return 2.7f;
    if ([hardware isEqualToString:@"iPad3,1"])      return 3.1f;
    if ([hardware isEqualToString:@"iPad3,2"])      return 3.2f;
    if ([hardware isEqualToString:@"iPad3,3"])      return 3.3f;
    if ([hardware isEqualToString:@"iPad3,4"])      return 3.4f;
    if ([hardware isEqualToString:@"iPad3,5"])      return 3.5f;
    if ([hardware isEqualToString:@"iPad3,6"])      return 3.6f;
    if ([hardware isEqualToString:@"iPad4,1"])      return 4.1f;
    if ([hardware isEqualToString:@"iPad4,2"])      return 4.2f;
    if ([hardware isEqualToString:@"iPad4,3"])      return 4.3f;
    if ([hardware isEqualToString:@"iPad4,4"])      return 4.4f;
    if ([hardware isEqualToString:@"iPad4,5"])      return 4.5f;
    
    if ([hardware isEqualToString:@"i386"])         return 100.0f;
    if ([hardware isEqualToString:@"x86_64"])       return 100.0f;
    return 200.0f;
}

- (float)hardwareNumber:(Hardware)hardware {
    switch (hardware) {
        case IPHONE_2G: return 1.1f;
        case IPHONE_3G: return 1.2f;
        case IPHONE_3GS: return 2.1f;
        case IPHONE_4:    return 3.1f;
        case IPHONE_4_CDMA:    return 3.3f;
        case IPHONE_4S:    return 4.1f;
        case IPHONE_5:    return 5.1f;
        case IPHONE_5_CDMA_GSM:    return 5.2f;
        case IPHONE_5C:    return 5.3f;
        case IPHONE_5C_CDMA_GSM:    return 5.4f;
        case IPHONE_5S:    return 6.1f;
        case IPHONE_5S_CDMA_GSM:    return 6.2f;
            
        case IPOD_TOUCH_1G:    return 1.1f;
        case IPOD_TOUCH_2G:    return 2.1f;
        case IPOD_TOUCH_3G:    return 3.1f;
        case IPOD_TOUCH_4G:    return 4.1f;
        case IPOD_TOUCH_5G:    return 5.1f;
            
        case IPAD:    return 1.1f;
        case IPAD_3G:    return 1.2f;
        case IPAD_2_WIFI:    return 2.1f;
        case IPAD_2:    return 2.2f;
        case IPAD_2_CDMA:    return 2.3f;
        case IPAD_MINI_WIFI:    return 2.5f;
        case IPAD_MINI:    return 2.6f;
        case IPAD_MINI_WIFI_CDMA:    return 2.7f;
        case IPAD_3_WIFI:    return 3.1f;
        case IPAD_3_WIFI_CDMA:    return 3.2f;
        case IPAD_3:    return 3.3f;
        case IPAD_4_WIFI:    return 3.4f;
        case IPAD_4:    return 3.5f;
        case IPAD_4_GSM_CDMA:    return 3.6f;
        case IPAD_AIR_WIFI:    return 4.1f;
        case IPAD_AIR_WIFI_GSM:    return 4.2f;
        case IPAD_AIR_WIFI_CDMA:    return 4.3f;
        case IPAD_MINI_RETINA_WIFI:    return 4.4f;
        case IPAD_MINI_RETINA_WIFI_CDMA:    return 4.5f;
            
        case SIMULATOR:    return 100.0f;
        case NOT_AVAILABLE:    return 200.0f;
    }
    return 200.0f; //Device is not available
}

- (BOOL)isCurrentDeviceHardwareBetterThan:(Hardware)hardware {
    float otherHardware = [self hardwareNumber:hardware];
    float currentHardware = [self hardwareNumber:[self hardware]];
    return currentHardware >= otherHardware;
}


+ (BOOL) isRetinaDisplay
{
    return ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] >= 2);
}

+ (BOOL) isPadDevice {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    }
    else {
        return NO;
    }
}

+ (BOOL) isPhoneDevice {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return YES;
    }
    else {
        return NO;
    }
}

+ (BOOL) isPhone5Device {
    if ([self isPhoneDevice] && [self getAdditionHeight] > 0) {
        return YES;
    }
    else {
        return NO;
    }
}

+ (BOOL) isSimulatorDevice {
#if TARGET_IPHONE_SIMULATOR
    return YES; // simulator
#elif TARGET_OS_IPHONE
    return NO; // device
#else
    return NO; // unknown
#endif
}

+ (NSString *) UDID {
    NSString *udid = @"";
    if ([[self currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
        udid = [[[self currentDevice]identifierForVendor]UUIDString];
    }
    else {
        CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
        udid = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, newUniqueId));
        
        CFRelease(newUniqueId);
    }
    return udid;
}

+ (BOOL) turnFlashTorch{
    
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

+ (void) turnFlashTorch:(BOOL)isOn{
    
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

+ (CGFloat)getRatioWidth{
    
    CGFloat ratioWidth = 1;
    if ([self isPadDevice]){
        ratioWidth = kLSRatioWidth;
    }
    
    return ratioWidth;
}

+ (CGFloat)getRatioHeight{
    
    CGFloat ratioHeight = 1;
    if ([self isPadDevice]){
        ratioHeight = kLSRatioHeight;
    }
    
    return ratioHeight;
}

+ (NSInteger)getRatioFontSize{
    
    CGFloat ratioFontSize = 1;
    if ([self isPadDevice]){
        ratioFontSize = 2;
    }
    
    return ratioFontSize;
}

+ (NSInteger)getAdditionHeight{
    
    CGFloat additionHeight = 0;
    if ([self isPhoneDevice]){
        if ([UIScreen mainScreen].bounds.size.height == 568.0f) {
            additionHeight = 568.0f - 480.0f;
        }
    }
    
    return additionHeight;
}

@end
