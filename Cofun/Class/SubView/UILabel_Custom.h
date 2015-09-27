//
//  UILabel_Custom.h
//  Cofun
//
//  Created by APPLE TINPHAT on 9/24/15.
//  Copyright © 2015 TVT25. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel_Custom : UILabel
@property (nonatomic) BOOL customFont;
@property (nonatomic) BOOL customTextColor;

+ (UIFont*)getTabbFont:(CGFloat)size;
+ (UIColor *)getTabbTextColor;
@end
