//
//  UITextField_Custom.h
//  Cofun
//
//  Created by APPLE TINPHAT on 9/24/15.
//  Copyright © 2015 TVT25. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"

@interface UITextField_Custom : TextFieldValidator
@property (nonatomic) BOOL customFont;
@property (nonatomic) BOOL customTextColor;
@property (nonatomic) BOOL hideClearButton;

- (BOOL)isHideClearButton;
@end
