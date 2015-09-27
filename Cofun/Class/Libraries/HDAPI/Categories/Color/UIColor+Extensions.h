//
//  UIColor+Extensions.h
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extensions)

- (NSString *)hexString;

///-----------------------------------------------------------------
/// Color
///-----------------------------------------------------------------
+ (instancetype)randomColor;
+ (instancetype)randomColor2;
+ (instancetype)colorWithRGB:(NSInteger)rgbValue;
+ (instancetype)colorFromHexString:(NSString *)hexString;


///-----------------------------------------------------------------
/// Gradient
///-----------------------------------------------------------------
+ (UIImage *)gradientImageWithSize:(CGSize)size topColor:(UIColor*)topColor bottomColor:(UIColor*)bottomColor isRadial:(BOOL)isRadial;
+ (void)setGradientTextColorForLabel:(UILabel*)label topColor:(UIColor*)topColor bottomColor:(UIColor*)bottomColor isRadial:(BOOL)isRadial;
+ (void)addLinearGradientToView:(UIView*)view topColor:(UIColor*)topColor bottomColor:(UIColor*)bottomColor;


///-----------------------------------------------------------------
/// iOS 7 Color
///-----------------------------------------------------------------

// Plain Colors
+ (instancetype)iOS7redColor;
+ (instancetype)iOS7orangeColor;
+ (instancetype)iOS7yellowColor;
+ (instancetype)iOS7greenColor;
+ (instancetype)iOS7lightBlueColor;
+ (instancetype)iOS7darkBlueColor;
+ (instancetype)iOS7purpleColor;
+ (instancetype)iOS7pinkColor;
+ (instancetype)iOS7darkGrayColor;
+ (instancetype)iOS7lightGrayColor;

// Gradient Colors
+ (instancetype)iOS7redGradientStartColor;
+ (instancetype)iOS7redGradientEndColor;

+ (instancetype)iOS7orangeGradientStartColor;
+ (instancetype)iOS7orangeGradientEndColor;

+ (instancetype)iOS7yellowGradientStartColor;
+ (instancetype)iOS7yellowGradientEndColor;

+ (instancetype)iOS7greenGradientStartColor;
+ (instancetype)iOS7greenGradientEndColor;

+ (instancetype)iOS7tealGradientStartColor;
+ (instancetype)iOS7tealGradientEndColor;

+ (instancetype)iOS7blueGradientStartColor;
+ (instancetype)iOS7blueGradientEndColor;

+ (instancetype)iOS7violetGradientStartColor;
+ (instancetype)iOS7violetGradientEndColor;

+ (instancetype)iOS7magentaGradientStartColor;
+ (instancetype)iOS7magentaGradientEndColor;

+ (instancetype)iOS7blackGradientStartColor;
+ (instancetype)iOS7blackGradientEndColor;

+ (instancetype)iOS7silverGradientStartColor;
+ (instancetype)iOS7silverGradientEndColor;

@end
