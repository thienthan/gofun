//
//  UIImage+Extensions.h
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extensions)

///-----------------------------------------------------------------
///
///-----------------------------------------------------------------
+ (UIImage *)imageFromResource:(NSString *)filename;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)fixRotation:(UIImage *)image;

- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage *)imageRoundedByRadius:(float)radius;

- (UIImage *)horizontallyStretchedImage;

///-----------------------------------------------------------------
/// Write
///-----------------------------------------------------------------
- (void)writeAsJPEGToURL:(NSURL *)url withCompression:(CGFloat) compression;
- (void)writeAsPNGToURL:(NSURL *)url;

///-----------------------------------------------------------------
/// Tint
///-----------------------------------------------------------------
- (UIImage *)imageTintedWithColor:(UIColor *)color;
- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction;

///-----------------------------------------------------------------
/// Resize
///-----------------------------------------------------------------
- (UIImage *)squareImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
- (UIImage*)resizedImageToSize:(CGSize)dstSize;
- (UIImage*)resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale;

///-----------------------------------------------------------------
/// Alpha
///-----------------------------------------------------------------
- (BOOL)hasAlpha;
- (UIImage *)imageWithAlpha;
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;
- (CGImageRef)newBorderMask:(NSUInteger)borderSize size:(CGSize)size;

///-----------------------------------------------------------------
/// Round
///-----------------------------------------------------------------
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;
- (void)addRoundedRectToPath:(CGRect)rect context:(CGContextRef)context ovalWidth:(CGFloat)ovalWidth ovalHeight:(CGFloat)ovalHeight;

///-----------------------------------------------------------------
/// Crop
///-----------------------------------------------------------------
typedef NS_ENUM(NSInteger, LSCropMode) {
	LSCropModeTopLeft,
	LSCropModeTopCenter,
	LSCropModeTopRight,
	LSCropModeBottomLeft,
	LSCropModeBottomCenter,
	LSCropModeBottomRight,
	LSCropModeLeftCenter,
	LSCropModeRightCenter,
	LSCropModeCenter
};

- (UIImage *)cropToSize:(CGSize)newSize usingMode:(LSCropMode)cropMode;
- (UIImage *)cropToSize:(CGSize)newSize;

///-----------------------------------------------------------------
/// Save
///-----------------------------------------------------------------
typedef NS_ENUM(NSInteger, LSImageType) {
	LSImageTypePNG,
	LSImageTypeJPEG,
	LSImageTypeGIF,
	LSImageTypeBMP,
	LSImageTypeTIFF
};

- (BOOL)saveToURL:(NSURL*)url uti:(CFStringRef)uti backgroundFillColor:(UIColor*)fillColor;
- (BOOL)saveToURL:(NSURL*)url type:(LSImageType)type backgroundFillColor:(UIColor*)fillColor;
- (BOOL)saveToURL:(NSURL*)url;
- (BOOL)saveToPath:(NSString*)path uti:(CFStringRef)uti backgroundFillColor:(UIColor*)fillColor;
- (BOOL)saveToPath:(NSString*)path type:(LSImageType)type backgroundFillColor:(UIColor*)fillColor;
- (BOOL)saveToPath:(NSString*)path;
- (BOOL)saveToPhotosAlbum;
+ (NSString*)extensionForUTI:(CFStringRef)uti;

///-----------------------------------------------------------------
/// Save
///-----------------------------------------------------------------
- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor;
@end
