//
//  UITextField_Custom.m
//  Cofun
//
//  Created by APPLE TINPHAT on 9/24/15.
//  Copyright © 2015 TVT25. All rights reserved.
//

#import "UITextField_Custom.h"

@implementation UITextField_Custom

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (self.customFont == NO) {
        NSString *fontName = FONT_DEFAULT;
        if( [[self.font fontName] rangeOfString:@"Bold"].location != NSNotFound || [[self.font fontName] rangeOfString:@"Medium"].location != NSNotFound)
            fontName = FONT_BOLD;
        
        self.font = [UIFont fontWithName:fontName size:self.font.pointSize];
    }
    
    if (self.customTextColor == NO) {
        [self setTextColor:TEXTFIELD_COLOR_DEFAULT];
    }
    
    //self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    if (!self.hideClearButton && !self.secureTextEntry) {
        [self setClearButtonMode:UITextFieldViewModeWhileEditing];
    }
    
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.layer setCornerRadius:3.0];
    [self.layer setMasksToBounds:YES];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 10.0f))];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [super editingRectForBounds:UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 10.0f))];
}

- (BOOL)isHideClearButton{
    return self.hideClearButton;
}


@end
