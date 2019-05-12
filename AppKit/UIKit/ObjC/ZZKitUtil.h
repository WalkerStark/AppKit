//
//  ZZKitUtil.h
//  ZZKit
//
//  Created by Walker Stark on 1/14/18.
//  Copyright © 2018 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * This class is for getting framework bundle.
 */
@interface ZZKitUtil : NSObject @end


#define ZZK_IS_PAD              (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define ZZK_IS_PHONE            (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define ZZK_IS_PORTRAIT         UIInterfaceOrientationIsPortrait(UIApplication.sharedApplication.statusBarOrientation)
#define ZZK_IS_LANDSCAPE        UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation)
#define ZZK_IS_LEFT_TO_RIGHT    (UIApplication.sharedApplication.userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionLeftToRight)
#define ZZK_IS_RIGHT_TO_LEFT    (UIApplication.sharedApplication.userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft)


NS_ASSUME_NONNULL_BEGIN

#pragma mark - Inline functions
#pragma mark -
NS_INLINE NSInteger ZZKRandomInteger(NSInteger min, NSInteger max) { return arc4random() % (max - min) + min; } // Exclude max
NS_INLINE CGFloat ZZKRandomFloat(CGFloat min, CGFloat max) { return (CGFloat)arc4random() / 0x100000000 * (max - min) + min; }  // Exclude max
NS_INLINE CGFloat ZZKPointDistance(CGPoint p1, CGPoint p2) { return sqrtf(powf(p2.x-p1.x, 2) + powf(p2.y-p1.y, 2)); }
NS_INLINE CGFloat ZZKRadianFromDegree(CGFloat degree) { return (degree * M_PI / 180.0); }

/**
 * Convenience method for extracting the full path to a resource stored in specified bundle. Support @1x/@2x/@3x suffix convention.
 * @warning This method does not guarantee that the resource exists! It will only return a well formed file path string to the requested resource. It is left to the consumer to verify the path exists or to build out the folder structure to that path if it doesn't already exist.
 * @param filePath The resource file path including extension in the specified bundle.
 * @param bundle The bundle which constains the resource file.
 * @return A URL path to the requested resource.
 */
FOUNDATION_EXPORT NSURL *__nullable ZZKURLForResourceInBundle(NSString *filePath, NSBundle *bundle);

/**
 * Convenience method for fetching the file names(@1x/@2x/@3x) of directory in the specified bundle. The fetched file name should be relevant with screen's scale.
 * @param directory The directory should be a reference folder(blue color).
 * @param bundle The bundle which constains the directory.
 * @return A list of file name in the directory.
 */
FOUNDATION_EXPORT NSArray<NSString *> *__nullable ZZKFileNamesOfDirectoryInBundle(NSString *directory, NSBundle *bundle);

NS_ASSUME_NONNULL_END
