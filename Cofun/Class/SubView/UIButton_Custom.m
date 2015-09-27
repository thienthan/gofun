//
//  UIButton_Custom.m
//  Cofun
//
//  Created by APPLE TINPHAT on 9/24/15.
//  Copyright © 2015 TVT25. All rights reserved.
//

#import "UIButton_Custom.h"

@implementation UIButton_Custom

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (self.customFont == NO) {
        NSString *fontName = FONT_DEFAULT;
        if( [[self.titleLabel.font fontName] rangeOfString:@"Bold"].location != NSNotFound || [[self.titleLabel.font fontName] rangeOfString:@"Medium"].location != NSNotFound)
            fontName = FONT_BOLD;
        self.titleLabel.font = [UIFont fontWithName:fontName size:self.titleLabel.font.pointSize];
    }
    
    if (self.customTextColor == NO) {
        [self setTitleColor:BUTTON_COLOR_DEFAULT forState:UIControlStateNormal];
        [self setTitleColor:BUTTON_COLOR_DEFAULT forState:UIControlStateHighlighted];
    }
    
    [self.layer setCornerRadius:3.0];
    [self.layer setMasksToBounds:YES];
    [self.layer setBorderWidth:1.0];
    [self.layer setBorderColor:BUTTON_COLOR_DEFAULT.CGColor];
}

- (void)setEnabled:(BOOL)enabled {
    
    [super setEnabled:enabled];
    
    if (enabled) {
        if (self.customTextColor == NO) {
            [self setTitleColor:BUTTON_COLOR_DEFAULT forState:UIControlStateNormal];
        }
        [self.layer setBorderColor:BUTTON_COLOR_DEFAULT.CGColor];
    } else {
        if (self.customTextColor == NO) {
            [self setTitleColor:BUTTON_COLOR_DISABLE forState:UIControlStateNormal];
        }
        [self.layer setBorderColor:BUTTON_COLOR_DISABLE.CGColor];
    }
}

- (BOOL)isExclusiveTouch {
    
    return YES;
}

@end
