//
//  NSFileManager+Extensions.h
//  VIN API Project
//
//  Created by SonHD on 9/26/13.
//  Copyright (c) 2013 SonHD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Extensions)

///-----------------------------------------------------------------
/// Path
///-----------------------------------------------------------------
+ (NSString *)libraryPath;
+ (NSString *)documentsPath;
+ (NSString *)cachesPath;
+ (NSString *)preferencesPath;
+ (NSString *)temporaryPath;
+ (NSString *)downloadPath;
+ (NSString *)applicationSupportPath;
+ (NSString *)currentDirectoryPath;

///-----------------------------------------------------------------
/// Application + Bundle Version
///-----------------------------------------------------------------
+ (NSString *)applicationVersion;
+ (NSString *)bundleVersion;

///-----------------------------------------------------------------
/// Check
///-----------------------------------------------------------------
+ (BOOL)fileExistsAtPath:(NSString *)path;
+ (BOOL)fileExistsAtPath:(NSString *)path isDirectory:(BOOL *)isDirectory;
+ (BOOL)isReadableFileAtPath:(NSString *)path;
+ (BOOL)isWritableFileAtPath:(NSString *)path;
+ (BOOL)isExecutableFileAtPath:(NSString *)path;
+ (BOOL)isDeletableFileAtPath:(NSString *)path;

+ (BOOL)isCorruptedPDFFileAtPath:(NSString *)path;
+ (BOOL)contentsEqualAtPath:(NSString *)path1 andPath:(NSString *)path2;

///-----------------------------------------------------------------
/// Move/Rename, Copy, Remove/Delete
///-----------------------------------------------------------------
+ (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error;
+ (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error;
+ (BOOL)removeItemAtPath:(NSString *)path error:(NSError **)error;
+ (BOOL)replaceItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error;
+ (BOOL)replaceItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath backupItemName:(NSString *)backupItemName error:(NSError **)error;

///-----------------------------------------------------------------
/// Create
///-----------------------------------------------------------------
+ (BOOL)createDirectoryAtPath:(NSString *)path withIntermediateDirectories:(BOOL)createIntermediates attributes:(NSDictionary *)attributes error:(NSError **)error;
+ (BOOL)createFileAtPath:(NSString *)path contents:(NSData *)data attributes:(NSDictionary *)attr;
+ (NSString *)createUniqueFileName;
+ (NSString *)createUniqueFileNameWithExtension:(NSString *)extension;

///-----------------------------------------------------------------
/// Read
///-----------------------------------------------------------------
+ (NSData *)contentsAtPath:(NSString *)path;
+ (NSArray *)contentsOfDirectoryAtPath:(NSString *)path error:(NSError **)error;
+ (NSDictionary *)attributesOfItemAtPath:(NSString *)path error:(NSError **)error;
+ (NSString *)displayNameAtPath:(NSString *)path;

+ (NSString *)fileNameAtPath:(NSString *)path;
+ (NSString *)fileExtensionAtPath:(NSString *)path;
+ (NSString *)fileNameExtensionAtPath:(NSString *)path;

+ (NSString *)fileExtensionOfFileInUrl:(NSURL *)url;

+ (float)getFreeDiskSpaceInBytes;

@end
