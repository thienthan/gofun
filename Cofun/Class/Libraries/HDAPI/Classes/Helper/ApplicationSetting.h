//
//  ApplicationSetting.h
//  VIN API Project
//
//  Created by SonHD on 11/5/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApplicationSetting : NSObject

@property (strong, nonatomic) NSString *applicationDisplayName;
@property (strong, nonatomic) NSString *applicationName;

@property (strong, nonatomic) NSString *applicationVersion;
@property (strong, nonatomic) NSString *applicationBuild;

@property (strong, nonatomic) NSString *iTunesVersion;
@property (strong, nonatomic) NSString *appStoreID;
@property (strong, nonatomic) NSString *iTunesURL;
@property (strong, nonatomic) NSString *iTunesLookup;

@property (strong, nonatomic) NSString *restURL;
@property (strong, nonatomic) NSString *API_KEY;

@property (strong, nonatomic) NSString *merchantName;
@property (strong, nonatomic) NSString *appleMerchantId;
@property (strong, nonatomic) NSString *homePageUrl;
@property (strong, nonatomic) NSString *emailContact;
@property (strong, nonatomic) NSString *phoneContact;
@property (strong, nonatomic) NSString *currencyCode;
@property (strong, nonatomic) NSNumber *shipping;
@property (strong, nonatomic) NSNumber *tax;

@property (nonatomic) BOOL isForcedUpdate;

@end
