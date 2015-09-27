//
//  UILabel_Custom.m
//  Cofun
//
//  Created by APPLE TINPHAT on 9/24/15.
//  Copyright © 2015 TVT25. All rights reserved.
//

#import "UILabel_Custom.h"

@implementation UILabel_Custom

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (self.customFont == NO) {
        NSString *fontName = FONT_DEFAULT;
        if( [[self.font fontName] rangeOfString:@"Bold"].location != NSNotFound || [[self.font fontName] rangeOfString:@"Medium"].location != NSNotFound)
            fontName = FONT_BOLD;
        
        [self setFont:[UIFont fontWithName:fontName size:self.font.pointSize]];
    }
    
    if (self.customTextColor == NO) {
        [self setTextColor:LABEL_COLOR_DEFAULT];
    }
}

+ (UIFont *)getTabbFont:(CGFloat)size {
    
    return [UIFont fontWithName:FONT_BOLD size:size];
}

+ (UIColor *)getTabbTextColor {
    
    return LABEL_COLOR_DEFAULT;
}
@end