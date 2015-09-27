//
//  UIView+Extensions.h
//  VIN API Project
//
//  Created by SonHD on 11/12/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extensions)

#pragma mark - Size
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

#pragma mark - Screenshot
- (UIImage *)screenshot;
- (UIImage *)screenshotPNG;
- (UIImage *)screenshotJPEG;

#pragma mark - Color
- (UIColor *)colorOfPoint:(CGPoint)point;

#pragma mark - FindFirstResponder
- (UIView *)findFirstResponder;
@end
