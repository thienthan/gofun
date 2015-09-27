//
//  NSData+Base64.h
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Base64)

+ (instancetype)dataWithBase64EncodedString:(NSString *)string;
- (NSString *)base64Encoding;

@end
