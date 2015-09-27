//
//  NSData+Extensions.h
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LSImageType) {
    LSImageType_NONE,
    LSImageType_PNG,
    LSImageType_JPEG,
    LSImageType_TIFF,
    LSImageType_GIF,
    LSImageType_BMP,
    LSImageType_PSD,
    LSImageType_PCX,
    LSImageType_RAS,
    LSImageType_SGI
};

@interface NSData (Extensions)

- (LSImageType)getImageType;

@end
