//
//  UIDevice+Hardware.h
//  VIN API Project
//
//  Created by SonHD on 1/24/14.
//  Copyright (c) 2014 SonHD. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IS_IPAD (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
#define DEVICE_IOS_VERSION [[UIDevice currentDevice].systemVersion floatValue]
#define DEVICE_HARDWARE_BETTER_THAN(i) [[UIDevice currentDevice] isCurrentDeviceHardwareBetterThan:i]

typedef NS_ENUM(NSInteger, Hardware)
{
    NOT_AVAILABLE,
    
    IPHONE_2G,
    IPHONE_3G,
    IPHONE_3GS,
    IPHONE_4,
    IPHONE_4_CDMA,
    IPHONE_4S,
    IPHONE_5,
    IPHONE_5_CDMA_GSM,
    IPHONE_5C,
    IPHONE_5C_CDMA_GSM,
    IPHONE_5S,
    IPHONE_5S_CDMA_GSM,
    
    IPOD_TOUCH_1G,
    IPOD_TOUCH_2G,
    IPOD_TOUCH_3G,
    IPOD_TOUCH_4G,
    IPOD_TOUCH_5G,
    
    IPAD,
    IPAD_2,
    IPAD_2_WIFI,
    IPAD_2_CDMA,
    IPAD_3,
    IPAD_3G,
    IPAD_3_WIFI,
    IPAD_3_WIFI_CDMA,
    IPAD_4,
    IPAD_4_WIFI,
    IPAD_4_GSM_CDMA,
    
    IPAD_MINI,
    IPAD_MINI_WIFI,
    IPAD_MINI_WIFI_CDMA,
    IPAD_MINI_RETINA_WIFI,
    IPAD_MINI_RETINA_WIFI_CDMA,
    
    IPAD_AIR_WIFI,
    IPAD_AIR_WIFI_GSM,
    IPAD_AIR_WIFI_CDMA,
    
    SIMULATOR
};

typedef NS_ENUM(NSInteger, HardwareType)
{
    NOT_AVAILABLE_TYPE,
    IPHONE_TYPE,
    IPOD_TOUCH_TYPE,
    IPAD_TYPE,
    IPAD_MINI_TYPE,
    SIMULATOR_TYPE
};

@interface UIDevice (Hardware)
/** This method retruns the hardware type */
- (NSString*)hardwareString;

/** This method returns the Hardware enum depending upon harware string */
- (Hardware)hardware;

/** This method returns the Hardware Type enum depending upon harware string */
- (HardwareType)hardwareType;

/** This method returns the Hardware Number depending upon harware string */
- (float)hardwareNumber;
- (float)hardwareNumber:(Hardware)hardware;

/** This method returns the readable description of hardware string */
- (NSString*)hardwareDescription;

/** This method returs the readble description without identifier (GSM, CDMA, GLOBAL) */
- (NSString *)hardwareSimpleDescription;

/** This method returns YES if the current device is better than the hardware passed */
- (BOOL)isCurrentDeviceHardwareBetterThan:(Hardware)hardware;

+ (BOOL) isRetinaDisplay;
+ (BOOL) isPadDevice;
+ (BOOL) isPhoneDevice;
+ (BOOL) isPhone5Device;
+ (BOOL) isSimulatorDevice;
+ (NSString *) UDID;
+ (BOOL)turnFlashTorch;
+ (void)turnFlashTorch:(BOOL)isOn;

+ (CGFloat)getRatioWidth;
+ (CGFloat)getRatioHeight;
+ (NSInteger)getRatioFontSize;
+ (NSInteger)getAdditionHeight;

@end
