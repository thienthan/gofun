//
//  NSData+AES.h
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES)

+ (instancetype)createRandomInitializationVector;
+ (instancetype)createRandomSalt;

+ (instancetype)AESEncryptedDataForData:(NSData *)data withPassword:(NSString *)password iv:(NSData *)iv salt:(NSData *)salt error:(NSError **)error;
+ (instancetype)dataForAESEncryptedData:(NSData *)data withPassword:(NSString *)password iv:(NSData *)iv salt:(NSData *)salt error:(NSError **)error;

- (NSData *)AESEncryptWithPassword:(NSString *)password iv:(NSData *)iv salt:(NSData *)salt error:(NSError **)error;
- (NSData *)AESDecryptWithPassword:(NSString *)password iv:(NSData *)iv salt:(NSData *)salt error:(NSError **)error;

@end
