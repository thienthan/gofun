//
//  UIViewController+Extensions.h
//  Tabb
//
//  Created by SonHD on 8/5/15.
//  Copyright (c) 2015 HD WEBSOFT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extensions)

- (UIViewController *)backViewController;
- (UIViewController *)firstViewController;
- (void)showViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)hideViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end
