//
//  LSLaunchApplication.h
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSLaunchApplication : NSObject

+ (BOOL)openAppWithUrlString:(NSString *)urlString;
+ (BOOL)launchSettingApp;
+ (BOOL)launchSafariApp:(NSString *)urlString;
+ (BOOL)launchSMSApp:(NSString *)phoneNumber;
+ (BOOL)launchCallApp:(NSString *)phoneNumber;
+ (BOOL)launchMailApp:(NSString *)emailAddress;
+ (BOOL)launchMailApp:(NSString *)emailAddress subject:(NSString *)subject body:(NSString *)body;
+ (BOOL)launchMailApp:(NSString *)emailAddress cc:(NSString *)cc bcc:(NSString *)bcc subject:(NSString *)subject body:(NSString *)body;
+ (BOOL)launchAppStoreApp:(NSString *)ituneUrlString;
+ (BOOL)launchAppWithUrlScheme:(NSString *)schemeUrlString;

+ (BOOL)launchGoogleMapApp:(NSString *)parameters;

@end
