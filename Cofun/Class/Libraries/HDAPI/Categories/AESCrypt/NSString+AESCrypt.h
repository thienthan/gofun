//
//  NSString+AESCrypt.h
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+AESCrypt.h"

@interface NSString (AESCrypt)

- (NSString *)AES256EncryptWithKey:(NSString *)key;
- (NSString *)AES256DecryptWithKey:(NSString *)key;

- (NSString *)AES192EncryptWithKey:(NSString *)key;
- (NSString *)AES192DecryptWithKey:(NSString *)key;

- (NSString *)AES128EncryptWithKey:(NSString *)key;
- (NSString *)AES128DecryptWithKey:(NSString *)key;

@end
