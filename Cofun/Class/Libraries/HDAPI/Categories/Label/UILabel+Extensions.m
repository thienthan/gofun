//
//  UILabel+Extensions.m
//  VIN API Project
//
//  Created by SonHD on 11/12/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import "UILabel+Extensions.h"

@implementation UILabel (Extensions)

- (void)autoHeight {
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    CGRect frame = self.frame;
    CGSize maxSize = CGSizeMake(frame.size.width, 9999);
    CGSize expectedSize = [self.text sizeWithFont:self.font constrainedToSize:maxSize lineBreakMode:self.lineBreakMode];
    frame.size.height = expectedSize.height;
    [self setFrame:frame];
#else
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.font, NSFontAttributeName,
                                [NSParagraphStyle defaultParagraphStyle], NSParagraphStyleAttributeName,
                                nil];
    CGRect bound = [self.text boundingRectWithSize:CGSizeMake(self.bounds.size.width, 9999) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil];
    [self setBounds:bound];
#endif
    
}

@end
