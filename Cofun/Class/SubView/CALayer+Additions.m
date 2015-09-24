//
//  CALayer+Additions.m
//  Tabb
//
//  Created by APPLE TINPHAT on 9/11/15.
//  Copyright (c) 2015 HD WEBSOFT. All rights reserved.
//

#import "CALayer+Additions.h"
#import  <UIKit/UIKit.h>
@implementation CALayer (Additions)
- (void)setBorderColorFromUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}
-(void)setShadowFromUIColor:(UIColor*)color
{
    self.shadowColor = color.CGColor;
}


@end
