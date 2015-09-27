//
//  UIView+Extensions.m
//  VIN API Project
//
//  Created by SonHD on 11/12/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import "UIView+Extensions.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Extensions)

#pragma mark - Size
- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

#pragma mark - Screenshot
- (UIImage *)fullScreenshot {
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];

    CGFloat scale = [UIScreen mainScreen].scale;
    CGRect bound = CGRectMake(0, 0, keyWindow.bounds.size.width * scale, keyWindow.bounds.size.height * scale);
    
    //old style
    //UIGraphicsBeginImageContext(bound.size);
    
    UIGraphicsBeginImageContextWithOptions(bound.size, NO, scale);
    //iOS 7
    [keyWindow drawViewHierarchyInRect:bound afterScreenUpdates:YES];
    
    //iOS 6
    //[keyWindow drawRect:bound];
    //[keyWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)screenshot {
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGRect bound = CGRectMake(0, 0, self.bounds.size.width * scale, self.bounds.size.height * scale);
    
    //old style
    //UIGraphicsBeginImageContext(bound.size);
    
    UIGraphicsBeginImageContextWithOptions(bound.size, NO, scale);
    BOOL hidden = [self isHidden];
    [self setHidden:NO];
    //iOS 7
    [self drawViewHierarchyInRect:bound afterScreenUpdates:YES];
    
    //iOS 6
    //[self drawRect:bound];
    //[self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self setHidden:hidden];
    
    return image;
}

- (UIImage *)screenshotPNG {

    return [self screenshot];
}

- (UIImage *)screenshotJPEG {
    
    NSData *imageData = UIImageJPEGRepresentation([self screenshot], 1);
    
    return [UIImage imageWithData:imageData];
}

#pragma mark - Color of point
- (UIColor *)colorOfPoint:(CGPoint)point
{
    unsigned char pixel[4] = {0};
    size_t width = 1;
    size_t height = 1;
    size_t bitsPerComponent = 8;
    size_t bytesPerPixel = 4;
    size_t bytesPerRow = (width * bitsPerComponent * bytesPerPixel + 7) / 8;
    //size_t dataSize = bytesPerRow * height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, width, height, bitsPerComponent, bytesPerRow, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);

    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    //NSLog(@"pixel: %d %d %d %d", pixel[0], pixel[1], pixel[2], pixel[3]);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}

#pragma mark - Find Fist Responder
- (UIView *)findFirstResponder {
	if(self.isFirstResponder) return self;
	
	for (UIView *subView in self.subviews) {
		UIView *firstResponder = [subView findFirstResponder];
		if (firstResponder != nil)
			return firstResponder;
	}
	return nil;
}

@end
