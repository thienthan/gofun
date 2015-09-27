//
//  UIColor+Extensions.m
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import "UIColor+Extensions.h"
#import <QuartzCore/QuartzCore.h>

#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

#if !__has_feature(objc_instancetype)
#error This library requires instancetype
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//#error This library requires iOS 7.0 or higher
#endif

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

@implementation UIColor (Extensions)

#pragma mark - hexString
- (NSString *)hexString {
    
	CGColorRef color = self.CGColor;
	size_t count = CGColorGetNumberOfComponents(color);
	const CGFloat *components = CGColorGetComponents(color);
	
	static NSString *stringFormat = @"#%02x%02x%02x";
	
	// Grayscale
	if (count == 2)
	{
		NSUInteger white = (NSUInteger)(components[0] * (CGFloat)255);
		return [NSString stringWithFormat:stringFormat, white, white, white];
	}
	
	// RGB
	else if (count == 4)
	{
		return [NSString stringWithFormat:stringFormat, (NSUInteger)(components[0] * (CGFloat)255),
				(NSUInteger)(components[1] * (CGFloat)255), (NSUInteger)(components[2] * (CGFloat)255)];
	}
	
	// Unsupported color space
	return nil;
}

#pragma mark - Color

+ (instancetype)randomColor {
    
	int r = arc4random() % 255;
	int g = arc4random() % 255;
	int b = arc4random() % 255;
    
	return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}

+ (instancetype)randomColor2 {
    //  0.0 to 1.0
    CGFloat hue = (arc4random() % 256 / 256.0);
    
    //  0.5 to 1.0, away from white
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;
    
    //  0.5 to 1.0, away from black
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;
    
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}

+ (instancetype)colorWithRGB:(NSInteger)rgbValue {
    
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f
                           green:((float)((rgbValue & 0xFF00) >> 8))/255.0f
                            blue:((float)(rgbValue & 0xFF))/255.0f
                           alpha:1.0];
}

// Assumes input like "#00FF00" (#RRGGBB).
+ (instancetype)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

#pragma mark - Gradient
+ (UIImage *)gradientImageWithSize:(CGSize)size topColor:(UIColor*)topColor bottomColor:(UIColor*)bottomColor isRadial:(BOOL)isRadial {
    
    CGFloat width = size.width;     // max 1024 due to Core Graphics limitations
    CGFloat height = size.height;   // max 1024 due to Core Graphics limitations
    
    // create a new bitmap image context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    // get context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // push context to make it current (need to do this manually because we are not drawing in a UIView)
    UIGraphicsPushContext(context);
    
    //draw gradient
    CGGradientRef glossGradient;
    CGColorSpaceRef rgbColorspace;
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    
    CGFloat r1 = 0.0, g1 = 0.0, b1 = 0.0, a1 = 0.0;
    
    if ([topColor respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [topColor getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
        
    }
    else {
        const CGFloat *components = CGColorGetComponents(topColor.CGColor);
        r1 = components[0];
        g1 = components[1];
        b1 = components[2];
        a1 = components[3];
    }
    
    CGFloat r2 = 0.0, g2 = 0.0, b2 = 0.0, a2 = 0.0;
    if ([bottomColor respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [bottomColor getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
        
    }
    else {
        const CGFloat *components = CGColorGetComponents(bottomColor.CGColor);
        r2 = components[0];
        g2 = components[1];
        b2 = components[2];
        a2 = components[3];
    }
    
    CGFloat components[8] = { r1, g1, b1, a1,  // Start color
        r2, g2, b2, a2 }; // End color
    
    rgbColorspace = CGColorSpaceCreateDeviceRGB();
    glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, num_locations);
    
    if (isRadial == NO) {
        CGPoint topCenter = CGPointMake(0, 0);
        CGPoint bottomCenter = CGPointMake(0, height);
        CGContextDrawLinearGradient(context, glossGradient, topCenter, bottomCenter, 0);
    }
    else {
        CGPoint center = CGPointMake(size.width/2, size.height/2);
        float radius = MIN(size.width ,size.height) ;
        CGContextDrawRadialGradient (context, glossGradient, center, 0, center, radius, kCGGradientDrawsAfterEndLocation);
    }
    
    CGGradientRelease(glossGradient);
    CGColorSpaceRelease(rgbColorspace);
    
    // pop context
    UIGraphicsPopContext();
    
    // get a UIImage from the image context
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // clean up drawing environment
    UIGraphicsEndImageContext();
    
    return  gradientImage;
}

+ (void)setGradientTextColorForLabel:(UILabel*)label topColor:(UIColor*)topColor bottomColor:(UIColor*)bottomColor isRadial:(BOOL)isRadial {
    
    label.textColor = [UIColor colorWithPatternImage:[self gradientImageWithSize:label.bounds.size topColor:topColor bottomColor:bottomColor isRadial:isRadial]];
}

+ (void)addLinearGradientToView:(UIView*)view topColor:(UIColor*)topColor bottomColor:(UIColor*)bottomColor
{
    for(CALayer* layer in view.layer.sublayers)
    {
        if ([layer isKindOfClass:[CAGradientLayer class]])
        {
            [layer removeFromSuperlayer];
        }
    }
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5,1);
    gradientLayer.frame = view.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
    gradientLayer.cornerRadius = view.layer.cornerRadius;
    view.clipsToBounds = YES;
    //view.layer.masksToBounds = YES;
    
    //[view.layer addSublayer:gradientLayer];
    if(view.layer.sublayers.count>0)
    {
        [view.layer insertSublayer:gradientLayer atIndex:(unsigned)view.layer.sublayers.count-2];
    }else {
        [view.layer addSublayer:gradientLayer];
    }
}

#pragma mark - iOS7 Color
// Plain Colors
+ (instancetype)iOS7redColor {
    return [UIColor colorFromHexString:@"#FF3B30"];
}

+ (instancetype)iOS7orangeColor {
    return [UIColor colorFromHexString:@"#FF9500"];
}

+ (instancetype)iOS7yellowColor {
    return [UIColor colorFromHexString:@"#FFCC00"];
}

+ (instancetype)iOS7greenColor {
    return [UIColor colorFromHexString:@"#4CD964"];
}

+ (instancetype)iOS7lightBlueColor {
    return [UIColor colorFromHexString:@"#34AADC"];
}

+ (instancetype)iOS7darkBlueColor {
    return [UIColor colorFromHexString:@"#007AFF"];
}

+ (instancetype)iOS7purpleColor {
    return [UIColor colorFromHexString:@"#5856D6"];
}

+ (instancetype)iOS7pinkColor {
    return [UIColor colorFromHexString:@"#FF2D55"];
}

+ (instancetype)iOS7darkGrayColor {
    return [UIColor colorFromHexString:@"#8E8E93"];
}

+ (instancetype)iOS7lightGrayColor {
    return [UIColor colorFromHexString:@"#C7C7CC"];
}


// Gradient Colors
+ (instancetype)iOS7redGradientStartColor {
    return [UIColor colorFromHexString:@"#FF5E3A"];
}

+ (instancetype)iOS7redGradientEndColor {
    return [UIColor colorFromHexString:@"#FF2A68"];
}

+ (instancetype)iOS7orangeGradientStartColor {
    return [UIColor colorFromHexString:@"#FF9500"];
}

+ (instancetype)iOS7orangeGradientEndColor {
    return [UIColor colorFromHexString:@"#FF5E3A"];
}

+ (instancetype)iOS7yellowGradientStartColor {
    return [UIColor colorFromHexString:@"#FFDB4C"];
}

+ (instancetype)iOS7yellowGradientEndColor {
    return [UIColor colorFromHexString:@"#FFCD02"];
}

+ (instancetype)iOS7greenGradientStartColor {
    return [UIColor colorFromHexString:@"#87FC70"];
}

+ (instancetype)iOS7greenGradientEndColor {
    return [UIColor colorFromHexString:@"#0BD318"];
}

+ (instancetype)iOS7tealGradientStartColor {
    return [UIColor colorFromHexString:@"#52EDC7"];
}

+ (instancetype)iOS7tealGradientEndColor {
    return [UIColor colorFromHexString:@"#5AC8FB"];
}

+ (instancetype)iOS7blueGradientStartColor {
    return [UIColor colorFromHexString:@"#1AD6FD"];
}

+ (instancetype)iOS7blueGradientEndColor {
    return [UIColor colorFromHexString:@"#1D62F0"];
}

+ (instancetype)iOS7violetGradientStartColor {
    return [UIColor colorFromHexString:@"#C644FC"];
}

+ (instancetype)iOS7violetGradientEndColor {
    return [UIColor colorFromHexString:@"#5856D6"];
}

+ (instancetype)iOS7magentaGradientStartColor {
    return [UIColor colorFromHexString:@"#EF4DB6"];
}

+ (instancetype)iOS7magentaGradientEndColor {
    return [UIColor colorFromHexString:@"#C643FC"];
}

+ (instancetype)iOS7blackGradientStartColor {
    return [UIColor colorFromHexString:@"#4A4A4A"];
}

+ (instancetype)iOS7blackGradientEndColor {
    return [UIColor colorFromHexString:@"#2B2B2B"];
}

+ (instancetype)iOS7silverGradientStartColor {
    return [UIColor colorFromHexString:@"#DBDDDE"];
}

+ (instancetype)iOS7silverGradientEndColor {
    return [UIColor colorFromHexString:@"#898C90"];
}

@end
