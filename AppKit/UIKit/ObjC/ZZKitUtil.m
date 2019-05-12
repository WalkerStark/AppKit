//
//  ZZKitUtil.m
//  ZZKit
//
//  Created by Walker Stark on 1/14/18.
//  Copyright © 2018 Stark. All rights reserved.
//

#import "ZZKitUtil.h"
#import "ZZFoundationUtil.h"

@implementation ZZKitUtil @end


/**
 * Get resource URL according to screen's scale (@1x/@2x/@3x...)
 */
static NSURL *URLForResourceInBundle(NSString *filePath, NSBundle *bundle, CGFloat scale)
{
    NSString *fileNameSuffix = ZZK_IS_PAD ? @"~ipad" : @"";
    NSString *newPath = [filePath.stringByDeletingPathExtension stringByAppendingFormat:@"@%.fx%@", scale, fileNameSuffix];
    NSURL *url = [bundle URLForResource:newPath withExtension:filePath.pathExtension];
    if (url) {
        return url;
    } else if (ZZK_IS_PAD) {
        newPath = [filePath.stringByDeletingPathExtension stringByAppendingFormat:@"@%.fx", scale];
        url = [bundle URLForResource:newPath withExtension:filePath.pathExtension];
        if (url) return url;
    }
    
    if (scale > 1) {
        return URLForResourceInBundle(filePath, bundle, scale - 1);
    } else {
        newPath = [filePath.stringByDeletingPathExtension stringByAppendingFormat:@"%@", fileNameSuffix];
        url = [bundle URLForResource:newPath withExtension:filePath.pathExtension];
        if (!url && ZZK_IS_PAD) {
            newPath = filePath.stringByDeletingPathExtension;
            url = [bundle URLForResource:newPath withExtension:filePath.pathExtension];
        }
        return url;
    }
}

NSURL *ZZKURLForResourceInBundle(NSString *filePath, NSBundle *bundle)
{
    return URLForResourceInBundle(filePath, bundle, UIScreen.mainScreen.nativeScale);
}


/**
 * Filter the file names according to screen's scale (@1x/@2x/@3x...)
 */
static NSArray<NSString *> *FilteredFileNamesInArray(NSArray<NSString *> *allFileNames, CGFloat scale)
{
    NSUInteger index = [allFileNames indexOfObjectPassingTest:^BOOL(NSString * _Nonnull fileName, NSUInteger idx, BOOL * _Nonnull stop) {
        return [fileName hasSuffix:@"~ipad"];
    }];
    
    BOOL hasPadSuffix = (index != NSNotFound);
    NSString *suffix = [NSString stringWithFormat:@"@%.fx%@", UIScreen.mainScreen.nativeScale, (ZZK_IS_PAD && hasPadSuffix) ? @"~ipad" : @""];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", suffix];
    NSArray *fileNames = [allFileNames filteredArrayUsingPredicate:predicate];
    if (fileNames.count > 0) return fileNames;
    
    if (scale > 1) {
        return FilteredFileNamesInArray(allFileNames, scale - 1);
    } else {
        if (hasPadSuffix) {
            fileNames = [allFileNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF CONTAINS[c] '~ipad' AND NOT SELF CONTAINS[c] '@'"]];
            if (fileNames.count > 0) return fileNames;
        }
        return [allFileNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"NOT SELF CONTAINS[c] '@'"]];
    }
}

NSArray<NSString *> *ZZKFileNamesOfDirectoryInBundle(NSString *directory, NSBundle *bundle)
{
    NSError *error = nil;
    NSString *dirPath = [bundle.resourcePath stringByAppendingPathComponent:directory];
    NSArray *allFileNames = [NSFileManager.defaultManager contentsOfDirectoryAtPath:dirPath error:&error];
    if (error) {
        ZZLog(@"ERROR: Failed to list contents of directory '%@'", directory);
        return [NSArray array];
    }
    NSArray *fileNames = FilteredFileNamesInArray(allFileNames, UIScreen.mainScreen.nativeScale);
    
    return [fileNames sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
}
