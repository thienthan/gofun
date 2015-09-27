//
//  LSLaunchApplication.m
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import "LSLaunchApplication.h"
#import <UIKit/UIApplication.h>

@implementation LSLaunchApplication

+ (BOOL)openAppWithUrlString:(NSString *)urlString {
    NSURL *url = [[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    return [[UIApplication sharedApplication] openURL:url];
}

+ (BOOL)launchSettingApp {
    return [self openAppWithUrlString:UIApplicationOpenSettingsURLString];
}

+ (BOOL)launchSafariApp :(NSString *)urlString{
    return [self openAppWithUrlString:urlString];
}

+ (BOOL)launchSMSApp:(NSString *)phoneNumber {
    NSString *urlString = [NSString stringWithFormat:@"sms:%@",phoneNumber];
    return [self openAppWithUrlString:urlString];
}

+ (BOOL)launchCallApp:(NSString *)phoneNumber {
    NSString *urlString = [NSString stringWithFormat:@"tel:%@",phoneNumber];
    return [self openAppWithUrlString:urlString];
}

+ (BOOL)launchMailApp:(NSString *)emailAddress {
    NSString *urlString = [NSString stringWithFormat:@"mailto:%@",emailAddress];
    return [self openAppWithUrlString:urlString];
}

+ (BOOL)launchMailApp:(NSString *)emailAddress subject:(NSString *)subject body:(NSString *)body {
    
    return [self launchMailApp:emailAddress cc:@"" bcc:@"" subject:subject body:body];
}

+ (BOOL)launchMailApp:(NSString *)emailAddress cc:(NSString *)cc bcc:(NSString *)bcc subject:(NSString *)subject body:(NSString *)body {
    
    NSString *recipients = [NSString stringWithFormat:@"mailto:%@?cc=%@&bcc=%@&subject=%@", emailAddress?emailAddress:@"", cc?cc:@"", bcc?bcc:@"", subject?subject:@""];
    NSString *mailBody = [NSString stringWithFormat:@"&body=%@", body?body:@""];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", recipients, mailBody];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return [self openAppWithUrlString:urlString];
}

+ (BOOL)launchAppStoreApp:(NSString *)ituneUrlString {
    NSString *urlString = [NSString stringWithFormat:@"itms-apps://%@",ituneUrlString];
    return [self openAppWithUrlString:urlString];
}

+ (BOOL)launchAppWithUrlScheme:(NSString *)schemeUrlString {
    return [self openAppWithUrlString:schemeUrlString];
}

+ (BOOL)launchGoogleMapApp:(NSString *)parameters {
    
    NSString *urlString = [NSString stringWithFormat:@"comgooglemaps://?%@",parameters];
    return [self openAppWithUrlString:urlString];
}

@end
