//
//  UIViewController+Extensions.m
//  Tabb
//
//  Created by SonHD on 8/5/15.
//  Copyright (c) 2015 HD WEBSOFT. All rights reserved.
//

#import "UIViewController+Extensions.h"

@implementation UIViewController (Extensions)

- (UIViewController *)backViewController {
    
    NSInteger myIndex = [self.navigationController.viewControllers indexOfObject:self];
    
    if ( myIndex != 0 && myIndex != NSNotFound ) {
        return [self.navigationController.viewControllers objectAtIndex:myIndex-1];
    }
    else {
        return nil;
    }
}

- (UIViewController *)firstViewController {
    
    NSInteger numberOfViewControllers = self.navigationController.viewControllers.count;
    
    if (numberOfViewControllers < 1) {
        return nil;
    }
    else {
        return [self.navigationController.viewControllers objectAtIndex:0];
    }
}

- (void)showViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:viewController.view];
    if (animated) {
        viewController.view.alpha = 0;
    }
    
    [window bringSubviewToFront:viewController.view];
    
    if (animated) {
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            viewController.view.alpha = 1;
        } completion:nil];
    }
    else {
        viewController.view.alpha = 1;
    }
}

- (void)hideViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (animated) {
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            viewController.view.alpha = 0;
        }completion:^(BOOL finished) {
            viewController.view.alpha = 1;
            [viewController.view removeFromSuperview];
        }];
    }
    else {
        [viewController.view removeFromSuperview];
    }
}

@end
