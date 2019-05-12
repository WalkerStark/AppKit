//
//  ZZKButton.h
//  ZZKit
//
//  Created by Walker Stark on 1/24/18.
//  Copyright © 2018 Stark. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ZZButtonLayout) {
    ZZButtonLayoutImageLeft,    // Default for image and title
    ZZButtonLayoutImageRight,
    ZZButtonLayoutImageUp,
    ZZButtonLayoutImageDown
};

@interface ZZKButton : UIControl

+ (instancetype)buttonWithTitle:(NSString *)title;
+ (instancetype)buttonWithTitle:(NSString *)title imageName:(NSString *)imageName;
+ (instancetype)buttonWithTitle:(NSString *)title imageName:(NSString *)imageName layout:(ZZButtonLayout)layout;
+ (instancetype)buttonWithTitle:(NSString *)title imageName:(NSString *)imageName disabledImageName:(NSString *)disabledImageName;
+ (instancetype)buttonWithTitle:(NSString *)title imageName:(NSString *)imageName disabledImageName:(NSString *)disabledImageName layout:(ZZButtonLayout)layout;

+ (instancetype)buttonWithImageName:(NSString *)imageName;
+ (instancetype)buttonWithImageName:(NSString *)imageName selectedImageName:(NSString *)selImageName;
+ (instancetype)buttonWithImageName:(NSString *)imageName disabledImageName:(NSString *)disabledImageName;

@property (nonatomic, assign) UIEdgeInsets contentEdgeInsets;   // Default is UIEdgeInsetsZero
@property (nonatomic, assign) CGFloat margin;   // Margin between title and image, default is 5.

// Return title and image views. Will always create them if necessary.
@property(nullable, nonatomic, readonly) UILabel     *titleLabel;
@property(nullable, nonatomic, readonly) UIImageView *imageView;

- (void)setTitle:(nullable NSString *)title forState:(UIControlState)state;
- (void)setTitleColor:(nullable UIColor *)color forState:(UIControlState)state;
- (void)setTitleShadowColor:(nullable UIColor *)color forState:(UIControlState)state;
- (void)setImage:(nullable UIImage *)image forState:(UIControlState)state;
- (void)setBackgroundImage:(nullable UIImage *)image forState:(UIControlState)state;
- (void)setBackgroundColor:(nullable UIColor *)color forState:(UIControlState)state;
- (void)setAttributedTitle:(nullable NSAttributedString *)title forState:(UIControlState)state;

- (nullable NSString *)titleForState:(UIControlState)state;
- (nullable UIColor *)titleColorForState:(UIControlState)state;
- (nullable UIColor *)titleShadowColorForState:(UIControlState)state;
- (nullable UIImage *)imageForState:(UIControlState)state;
- (nullable UIImage *)backgroundImageForState:(UIControlState)state;
- (nullable UIColor *)backgroundColorForState:(UIControlState)state;
- (nullable NSAttributedString *)attributedTitleForState:(UIControlState)state NS_AVAILABLE_IOS(6_0);

@property(nullable, nonatomic,readonly,strong) NSString *currentTitle;
@property(nonatomic, readonly) UIColor  *currentTitleColor;         // Default is white
@property(nonatomic, readonly) UIColor  *currentBackgroundColor;    // Default is clearColor
@property(nullable, nonatomic, readonly) UIColor  *currentTitleShadowColor;
@property(nullable, nonatomic, readonly) UIImage  *currentImage;
@property(nullable, nonatomic, readonly) UIImage  *currentBackgroundImage;
@property(nullable, nonatomic, readonly) NSAttributedString *currentAttributedTitle;

@end

NS_ASSUME_NONNULL_END
