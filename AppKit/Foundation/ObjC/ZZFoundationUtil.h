//
//  ZZFoundationUtil.h
//  ZZFoundation
//
//  Created by Walker Stark on 10/23/17.
//  Copyright © 2017 Stark. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Define macros
#pragma mark -

#define ZZ_APP_BUNDLE_NAME      NSBundle.mainBundle.infoDictionary[@"CFBundleName"]
#define ZZ_APP_BUNDLE_ID        NSBundle.mainBundle.infoDictionary[@"CFBundleIdentifier"]
#define ZZ_APP_VERSION          NSBundle.mainBundle.infoDictionary[@"CFBundleShortVersionString"]
#define ZZ_APP_BUILD_NUMBER     NSBundle.mainBundle.infoDictionary[@"CFBundleVersion"]
#define ZZ_APP_DISPLAY_NAME     NSBundle.mainBundle.localizedInfoDictionary[@"CFBundleDisplayName"]
#define ZZ_APP_COPYRIGHT        NSBundle.mainBundle.localizedInfoDictionary[@"NSHumanReadableCopyright"]

#if DEBUG
#define ZZLog(format, ...)      NSLog(@"%@:%d: %@", [NSString stringWithUTF8String:__FILE__].lastPathComponent, __LINE__, [NSString stringWithFormat:format, ##__VA_ARGS__]);
#else
#define ZZLog(format, ...)
#endif


#pragma mark - Define types
#pragma mark -
typedef void (^ZZVoidBlockType)(void);
typedef void (^ZZBoolBlockType)(BOOL finished);
typedef void (^ZZObjectBlockType)(id object);


#pragma mark - Inline functions
#pragma mark -
NS_INLINE BOOL ZZSystemVersionGreaterThanOrEqualTo(NSInteger version) {
    return NSProcessInfo.processInfo.operatingSystemVersion.majorVersion > version;
}

NS_INLINE NSString *ZZLocalizedStringFromTableInBundle(NSString *key, NSString *table, NSBundle *bundle) {
    NSString *stringValue = NSLocalizedString(key, "");     // Load from main bunlde first
    return [stringValue isEqualToString:key] ? NSLocalizedStringFromTableInBundle(key, table, bundle, "") : stringValue;
}


#pragma mark - File path util functions
#pragma mark -
/**
 * Retrieve the full path URL for a file, given a path relative to the a documents folder.
 * The documents folder is intended for critical user data and app files that can not be recreated (Example: User-generated content) and should be backed up by iTunes or iCloud backups.
 * @warning This method does not guarantee that the resource exists! It will only return a well formed file path string to the requested resource. It is left to the consumer to verify the path exists or to build out the folder structure to that path if it doesn't already exist.
 * @param filePath The path to a folder or file with extension in the application sandbox directory.
 * @return A URL to the requested documents resource.
 */
FOUNDATION_EXPORT NSString *ZZSearchPathForDocument(NSString *filePath);

/**
 * Retrieve the full path URL for a file, given a path relative to the cache folder.
 */
FOUNDATION_EXPORT NSString *ZZSearchPathForCache(NSString *filePath);

/**
 * Retrieve the full path URL for a file, given a path relative to the temp folder.
 */
FOUNDATION_EXPORT NSString *ZZSearchPathForTemporary(NSString *filePath);


#pragma mark - Runtime util functions
#pragma mark -
/**
 * @param clazz A class or meta class
 */
FOUNDATION_EXPORT NSArray<NSString *> *ZZClassSubClassNamesForClass(Class clazz);

/**
 * Retrieve object's description including all properties' key and value.
 * @param object A object or class
 */
FOUNDATION_EXPORT NSString *ZZClassPropertyDescriptionForObject(id object);

/**
 * @param clazz A class or meta class (e.g. [NSObject class] or object_getClass([NSObject class]))
 */
FOUNDATION_EXPORT void ZZClassSwizzleMethod(Class clazz, SEL originalSelector, SEL swizzledSelector);

NS_ASSUME_NONNULL_END
