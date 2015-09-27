//
//  ConnectionManager.m
//  VIN API Project
//
//  Created by SonHD on 12/20/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import "ConnectionManager.h"
#import "Reachability.h"

#define RA_HOST @"www.google.com"

@interface ConnectionManager() {
    Reachability *internetReachable;
    Reachability *hostReachable;
    
    NetworkStatusChangedBlock _block;
}

@end

@implementation ConnectionManager
@synthesize internetActive;
@synthesize hostActive;

+ (BOOL)connected {
    
    /*
     Reachability *reachabilityI = [Reachability reachabilityForInternetConnection];
     NetworkStatus networkStatusI = [reachabilityI currentReachabilityStatus];
     BOOL internetConnected = (networkStatusI != NotReachable);
     
     Reachability *reachabilityH = [Reachability reachabilityWithHostName:RA_HOST];
     NetworkStatus networkStatusH = [reachabilityH currentReachabilityStatus];
     BOOL hostConnected = (networkStatusH != NotReachable);
     
     BOOL connected = internetConnected && hostConnected;
     */
    
    BOOL connected = [[self class] connectedToInternet];
    NSLog(@"Internet Connected: %@", connected ? @"YES" : @"NO");
    
    return connected;
}

+ (BOOL)connectedToInternet {
    
    NSURL *url = [NSURL URLWithString:@"https://www.google.com/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"HEAD"];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [request setTimeoutInterval:5.0f];
    NSHTTPURLResponse *response;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error: NULL];
    NSInteger statusCode = [response statusCode];
    NSLog(@"Connection status code: %li", statusCode);
    
    return (statusCode == 200) ? YES : NO;
}

+ (BOOL)connectedToInternet2 {
    
    bool success = false;
    const char *host_name = [RA_HOST cStringUsingEncoding:NSASCIIStringEncoding];
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host_name);
    SCNetworkReachabilityFlags flags;
    success = SCNetworkReachabilityGetFlags(reachability, &flags);
    bool isAvailable = success && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
    CFRelease(reachability);
    
    if (isAvailable) {
        NSLog(@"Host is reachable: %d", flags);
    }else{
        NSLog(@"Host is unreachable");
    }
    return isAvailable;
}

- (id)init {
    
    self = [super init];
    if(self) {
        
    }
    
    return self;
}

- (void)startMonitorNetworkStatusChangedWithBlock:(NetworkStatusChangedBlock)block {
    
    NSLog(@"startMonitorNetworkStatusChangedWithBlock.");
    
    if (block) {
        _block = block;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    /*
     internetReachable = [Reachability reachabilityForInternetConnection];
     [internetReachable startNotifier];
     [self reachabilityChanged:nil];
     */
    
    hostReachable = [Reachability reachabilityWithHostName:RA_HOST];
    [hostReachable startNotifier];
    [self reachabilityChanged:nil];
}

- (void)stopMonitorNetworkStatusChanged {
    
    NSLog(@"stopMonitorNetworkStatusChanged.");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reachabilityChanged:(NSNotification *)note {
    
    /*
     NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
     switch (internetStatus)
     {
     case NotReachable:
     {
     //NSLog(@"The internet is down.");
     self.internetActive = NO;
     if (_block && note) {
     _block(self.internetActive);
     }
     break;
     }
     case ReachableViaWiFi:
     {
     //NSLog(@"The internet is working via WIFI.");
     self.internetActive = YES;
     if (_block && note) {
     _block(self.internetActive);
     }
     break;
     }
     case ReachableViaWWAN:
     {
     //NSLog(@"The internet is working via WWAN.");
     self.internetActive = YES;
     if (_block && note) {
     _block(self.internetActive);
     }
     break;
     }
     }
     */
    
    NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
    switch (hostStatus)
    {
        case NotReachable:
        {
            NSLog(@"A gateway to the host server is down.");
            self.hostActive = NO;
            if (_block && note) {
                _block(self.hostActive);
            }
            break;
            
        }
        case ReachableViaWiFi:
        {
            NSLog(@"A gateway to the host server is working via WIFI.");
            self.hostActive = YES;
            if (_block && note) {
                _block(self.hostActive);
            }
            break;
            
        }
        case ReachableViaWWAN:
        {
            NSLog(@"A gateway to the host server is working via WWAN.");
            self.hostActive = YES;
            if (_block && note) {
                _block(self.hostActive);
            }
            break;
            
        }
    }
    
}

// If lower than SDK 5 : Otherwise, remove the observer as pleased.

- (void)dealloc {
    
    NSLog(@"ConnectionManager dealloc.");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end