//
//  CALayer+Additions.h
//  Tabb
//
//  Created by APPLE TINPHAT on 9/11/15.
//  Copyright (c) 2015 HD WEBSOFT. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface CALayer (Additions)
- (void)setBorderColorFromUIColor:(UIColor *)color;
-(void)setShadowFromUIColor:(UIColor*)color;

@end
