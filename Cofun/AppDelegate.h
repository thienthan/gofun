//
//  AppDelegate.h
//  Cofun
//
//  Created by APPLE TINPHAT on 9/24/15.
//  Copyright © 2015 TVT25. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import  <MapKit/MapKit.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate, MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic) BOOL isCheckInVietNam;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)setUpGetLocation;
- (void)requestAlwaysAuthorization;


@end

