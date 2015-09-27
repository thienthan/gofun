//
//  ConnectionManager.h
//  VIN API Project
//
//  Created by SonHD on 12/20/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^NetworkStatusChangedBlock)(BOOL status);

@interface ConnectionManager : NSObject

@property(nonatomic) BOOL internetActive;
@property(nonatomic) BOOL hostActive;

+ (BOOL)connected;
- (void)startMonitorNetworkStatusChangedWithBlock:(NetworkStatusChangedBlock)block;
- (void)stopMonitorNetworkStatusChanged;

@end
