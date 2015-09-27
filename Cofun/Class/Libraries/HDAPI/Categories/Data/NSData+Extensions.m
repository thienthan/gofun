//
//  NSData+Extensions.m
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import "NSData+Extensions.h"

#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

#if !__has_feature(objc_instancetype)
#error This library requires instancetype
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//#error This library requires iOS 7.0 or higher
#endif

@implementation NSData (Extensions)


- (LSImageType)getImageType {
    
    LSImageType imgType;
    NSInteger head;
    [self getBytes:&head range:NSMakeRange(0, 2)];
    
    head = head & 0x0000FFFF;
    //NSLog(@"%d, %x", head, head);
    switch (head)
    {
        case 0x4D42:
            imgType = LSImageType_BMP;
            break;
            
        case 0xD8FF:
            imgType = LSImageType_JPEG;
            break;
            
        case 0x4947:
            imgType = LSImageType_GIF;
            break;
            
        case 0x050A:
            imgType = LSImageType_PCX;
            break;
            
        case 0x5089:
            imgType = LSImageType_PNG;
            break;
            
        case 0x4238:
            imgType = LSImageType_PSD;
            break;
            
        case 0xA659:
            imgType = LSImageType_RAS;
            break;
            
        case 0xDA01:
            imgType = LSImageType_SGI;
            break;
            
        case 0x4949:
            imgType = LSImageType_TIFF;
            break;
            
        default:
            imgType = LSImageType_NONE;
            break;
    }
    
    return imgType;
}

@end
