//
//  UIViewController+Container.h
//  TripScout
//
//  Created by Son on 2/27/15.
//  Copyright (c) 2015 SonHD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Container)

- (void)containerAddChildViewController:(UIViewController *)childViewController parentView:(UIView *)view;

- (void)containerAddChildViewController:(UIViewController *)childViewController toContainerView:(UIView *)view useAutolayout:(BOOL)autolayout;

- (void)containerAddChildViewController:(UIViewController *)childViewController toContainerView:(UIView *)view;

- (void)containerAddChildViewController:(UIViewController *)childViewController;

- (void)containerRemoveChildViewController:(UIViewController *)childViewController;
@end
