//
//  NSData+AES.m
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import "NSData+AES.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>

#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

#if !__has_feature(objc_instancetype)
#error This library requires instancetype
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//#error This library requires iOS 7.0 or higher
#endif

@implementation NSData (AES)


#pragma mark Methods needed in CBC crypto.

+ (instancetype)createRandomInitializationVector
{
    NSData *data = [NSData createRandomDataWithLengh:kCCBlockSizeAES128];
    return data;
}

+ (instancetype)createRandomSalt
{
    NSData *data = [NSData createRandomDataWithLengh:8];
    return data;
}

+ (instancetype)AESEncryptedDataForData:(NSData *)data withPassword:(NSString *)password iv:(NSData *)iv salt:(NSData *)salt error:(NSError **)error
{
    return [data AESEncryptWithPassword:password iv:iv salt:salt error:error];
}

+ (instancetype)dataForAESEncryptedData:(NSData *)data withPassword:(NSString *)password iv:(NSData *)iv salt:(NSData *)salt error:(NSError **)error
{
    return [data AESDecryptWithPassword:password iv:iv salt:salt error:error];
}


- (NSData *)AESEncryptWithPassword:(NSString *)password iv:(NSData *)iv salt:(NSData *)salt error:(NSError **)error
{
    NSData *key = [NSData keyForPassword:password salt:salt];
    size_t outLength;
    NSMutableData *cipherData = [NSMutableData dataWithLength:self.length + kCCBlockSizeAES128];
    
    CCCryptorStatus result = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding, key.bytes, key.length, iv.bytes, self.bytes, self.length, cipherData.mutableBytes, cipherData.length, &outLength);
    
    if(result == kCCSuccess)
    {
        cipherData.length = outLength;
    }
    else if(error)
    {
        *error = [NSError errorWithDomain:@"com.jlaube.crypto" code:result userInfo:nil];
        return nil;
    }
    return cipherData;
}

- (NSData *)AESDecryptWithPassword:(NSString *)password iv:(NSData *)iv salt:(NSData *)salt error:(NSError **)error
{
    NSData *key = [NSData keyForPassword:password salt:salt];
    size_t outLength;
    NSMutableData *clearData = [NSMutableData dataWithLength:self.length + kCCBlockSizeAES128];
    
    CCCryptorStatus result = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding, key.bytes, key.length, iv.bytes, self.bytes, self.length, clearData.mutableBytes, clearData.length, &outLength);
    
    if(result == kCCSuccess)
    {
        clearData.length = outLength;
    }
    else if(error)
    {
        *error = [NSError errorWithDomain:@"com.jlaube.crypto" code:result userInfo:nil];
        return nil;
    }
    return clearData;
}

+ (instancetype)createRandomDataWithLengh:(NSUInteger)length
{
    NSMutableData *data = [[NSMutableData alloc] initWithLength:length];
    SecRandomCopyBytes(kSecRandomDefault, length, data.mutableBytes);
    return data;
}

+ (instancetype)keyForPassword:(NSString *)password salt:(NSData *)salt
{
    NSMutableData *key = [NSMutableData dataWithLength:kCCKeySizeAES128];
    CCKeyDerivationPBKDF(kCCPBKDF2, password.UTF8String, password.length, salt.bytes, salt.length, kCCPRFHmacAlgSHA1, 10000, key.mutableBytes, key.length);
    
    return key;
}

@end
