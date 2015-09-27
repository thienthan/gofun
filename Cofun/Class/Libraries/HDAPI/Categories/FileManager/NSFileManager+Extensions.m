//
//  NSFileManager+Extensions.m
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import "NSFileManager+Extensions.h"
#import <CoreGraphics/CoreGraphics.h>

#if !__has_feature(objc_arc)
#error This library requires automatic reference counting
#endif

#if !__has_feature(objc_instancetype)
#error This library requires instancetype
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
//#error This library requires iOS 7.0 or higher
#endif

@implementation NSFileManager (Extensions)


#pragma mark - Path
+ (NSString *)libraryPath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    return [paths objectAtIndex:0];
}

+ (NSString *)documentsPath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [paths objectAtIndex:0];
}

+ (NSString *)cachesPath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    return [paths objectAtIndex:0];
}

+ (NSString *)preferencesPath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    return [NSString stringWithFormat:@"%@/Preferences",[paths objectAtIndex:0]];
}

+ (NSString *)temporaryPath {
    
    return NSTemporaryDirectory();
}

+ (NSString *)downloadPath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDownloadsDirectory, NSUserDomainMask, YES);
    
    return [paths objectAtIndex:0];
}

+ (NSString *)applicationSupportPath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    
    return [paths objectAtIndex:0];
}

+ (NSString *)currentDirectoryPath {
    return [[self defaultManager] currentDirectoryPath];
}

#pragma mark - Application + Bundle Version
+ (NSString *)applicationVersion {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)bundleVersion {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}


#pragma mark - Check
+ (BOOL)fileExistsAtPath:(NSString *)path {
    
    return [[self defaultManager] fileExistsAtPath:path];
}

+ (BOOL)fileExistsAtPath:(NSString *)path isDirectory:(BOOL *)isDirectory {
    
    return [[self defaultManager] fileExistsAtPath:path isDirectory:isDirectory];
}

+ (BOOL)isReadableFileAtPath:(NSString *)path {
    
    return [[self defaultManager] isReadableFileAtPath:path];
}

+ (BOOL)isWritableFileAtPath:(NSString *)path {
    
    return [[self defaultManager] isWritableFileAtPath:path];
}

+ (BOOL)isExecutableFileAtPath:(NSString *)path {
    
    return [[self defaultManager] isExecutableFileAtPath:path];
}

+ (BOOL)isDeletableFileAtPath:(NSString *)path {
    
    return [[self defaultManager] isDeletableFileAtPath:path];
}

+ (BOOL)isCorruptedPDFFileAtPath:(NSString *)path {
    
    BOOL isCorrupted = NO;
    
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"A_Corrupted_PDF" ofType:@"pdf"];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    CGPDFDocumentRef document = CGPDFDocumentCreateWithProvider(provider);
    
    if (document == nil) {
        NSLog(@"File is corrupted.");
        isCorrupted = YES;
    }
    CGDataProviderRelease(provider);
    CGPDFDocumentRelease(document);
    
    return isCorrupted;
}

+ (BOOL)contentsEqualAtPath:(NSString *)path1 andPath:(NSString *)path2 {
    
    return [[self defaultManager] contentsEqualAtPath:path1 andPath:path2];
}

#pragma mark - Move/Rename, Copy, Remove/Delete
+ (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error {
    
    if ([self fileExistsAtPath:srcPath]) {
        return [[self defaultManager] copyItemAtPath:srcPath toPath:dstPath error:error];
    }
    return NO;
}

+ (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error {
    
    if ([self fileExistsAtPath:srcPath]) {
        return [[self defaultManager] moveItemAtPath:srcPath toPath:dstPath error:error];
    }
    return NO;
}

+ (BOOL)removeItemAtPath:(NSString *)path error:(NSError **)error {
    
    if ([self fileExistsAtPath:path]) {
        return [[self defaultManager] removeItemAtPath:path error:error];
    }
    return NO;
}

+ (BOOL)replaceItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error {
    
    BOOL isRemoved = NO;
    if ([self fileExistsAtPath:dstPath]) {
        
        isRemoved = [[self defaultManager] removeItemAtPath:dstPath error:error];
    }
    else {
        isRemoved = YES;
    }
    
    if (isRemoved) {
        return [[self class] copyItemAtPath:srcPath toPath:dstPath error:error];
    }
    return NO;
}

+ (BOOL)replaceItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath backupItemName:(NSString *)backupItemName error:(NSError **)error {
    
    return [[self defaultManager] replaceItemAtURL:[[NSURL alloc]initFileURLWithPath:srcPath] withItemAtURL:[[NSURL alloc]initFileURLWithPath:dstPath] backupItemName:backupItemName options:NSFileManagerItemReplacementUsingNewMetadataOnly resultingItemURL:nil error:error];
}

#pragma mark - Create
+ (BOOL)createDirectoryAtPath:(NSString *)path withIntermediateDirectories:(BOOL)createIntermediates attributes:(NSDictionary *)attributes error:(NSError **)error {
    
    return [[self defaultManager] createDirectoryAtPath:path withIntermediateDirectories:createIntermediates attributes:attributes error:error];
}

+ (BOOL)createFileAtPath:(NSString *)path contents:(NSData *)data attributes:(NSDictionary *)attr {
    
    return [[self defaultManager] createFileAtPath:path contents:data attributes:attr];
}

+ (NSString *)createUniqueFileName {
    
    NSString *fileName;
    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIdString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
    fileName = (__bridge NSString *)newUniqueIdString;
    CFRelease(newUniqueId);
    CFRelease(newUniqueIdString);
    
    return fileName;
}

+ (NSString *)createUniqueFileNameWithExtension:(NSString *)extension {
    
    return [[self createUniqueFileName] stringByAppendingPathExtension:extension];
}

#pragma mark - Read
+ (NSData *)contentsAtPath:(NSString *)path {
    
    if ([self fileExistsAtPath:path]) {
        return [[self defaultManager] contentsAtPath:path];
        //return [[NSData alloc] initWithContentsOfFile:path];
    }
    return nil;
}

+ (NSArray *)contentsOfDirectoryAtPath:(NSString *)path error:(NSError **)error {
    
    if ([self fileExistsAtPath:path]) {
        return [[self defaultManager] contentsOfDirectoryAtPath:path error:error];
    }
    return nil;
}

+ (NSDictionary *)attributesOfItemAtPath:(NSString *)path error:(NSError **)error {
    
    if ([self fileExistsAtPath:path]) {
        return [[self defaultManager] attributesOfItemAtPath:path error:error];
    }
    return nil;
}

+ (NSString *)displayNameAtPath:(NSString *)path {
    
    if ([self fileExistsAtPath:path]) {
        return [[self defaultManager] displayNameAtPath:path];
    }
    return nil;
}

+ (NSString *)fileNameAtPath:(NSString *)path {
    
    return [[path lastPathComponent] stringByDeletingPathExtension];
}

+ (NSString *)fileExtensionAtPath:(NSString *)path {
    
    return [path pathExtension];
}

+ (NSString *)fileNameExtensionAtPath:(NSString *)path {
    
    return [path lastPathComponent];
}

+ (NSString *)fileExtensionOfFileInUrl:(NSURL *)url {
    
    NSString *urlString = [url absoluteString];
    NSArray *componentsArray = [urlString componentsSeparatedByString:@"."];
    NSString *fileExtension = [componentsArray lastObject];
    return  fileExtension;
}

+ (float)getFreeDiskSpaceInBytes {
    
    float totalSpace = 0.0f;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary)
    {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemFreeSize];		//Or NSFileSystemSize for total size
        totalSpace = [fileSystemSizeInBytes floatValue];
    }
    else
    {
        NSLog(@"Error Obtaining File System Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
    
    return totalSpace;
}

@end
