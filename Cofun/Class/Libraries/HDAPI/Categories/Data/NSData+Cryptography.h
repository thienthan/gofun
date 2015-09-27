//
//  NSData+Cryptography.h
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Cryptography)

- (NSData *)encryptedDataUsingSHA1WithKey:(NSData *)key;
- (NSData *)dataWithMD5Hash;

@end
