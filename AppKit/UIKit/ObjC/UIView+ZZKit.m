//
//  UIView+ZZKit.m
//  ZZKit
//
//  Created by Walker Stark on 1/14/18.
//  Copyright © 2018 Stark. All rights reserved.
//

#import "UIView+ZZKit.h"

static const NSInteger kTopBorderTag = 9001;
static const NSInteger kDimBackgroundTag = 9002;

@implementation UIView (ZZKit)

#pragma mark - Auto Layout
#pragma mark -
+ (instancetype)zzk_newAutoLayoutView
{
    UIView *view = [[self alloc] init];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}

- (void)zzk_constraintEqualWithSuperView
{
    NSDictionary *views = NSDictionaryOfVariableBindings(self);
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[self]|" options:0 metrics:nil views:views]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[self]|" options:0 metrics:nil views:views]];
}

- (void)zzk_constraintCenterInSuperview
{
    [self zzk_constraintCenterXInSuperview];
    [self zzk_constraintCenterYInSuperview];
}

- (void)zzk_constraintCenterXInSuperview
{
    UILayoutGuide *leadingGuide = [UILayoutGuide new];
    UILayoutGuide *trailingGuide = [UILayoutGuide new];
    [self.superview addLayoutGuide:leadingGuide];
    [self.superview addLayoutGuide:trailingGuide];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(self, leadingGuide, trailingGuide);
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[leadingGuide][self][trailingGuide(leadingGuide)]|" options:0 metrics:nil views:views]];
}

- (void)zzk_constraintCenterYInSuperview
{
    UILayoutGuide *topGuide = [UILayoutGuide new];
    UILayoutGuide *bottomGuide = [UILayoutGuide new];
    [self.superview addLayoutGuide:topGuide];
    [self.superview addLayoutGuide:bottomGuide];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(self, topGuide, bottomGuide);
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topGuide][self][bottomGuide(topGuide)]|" options:0 metrics:nil views:views]];
}

#pragma mark - Shadow and Border
#pragma mark -
- (void)zzk_addTopShadow
{
    self.layer.shadowRadius = 0.0;
    self.layer.shadowOpacity = 20.0/255.0;
    self.layer.shadowOffset = CGSizeMake(0, -3.0);
    self.layer.shadowColor = UIColor.blackColor.CGColor;
}

- (void)zzk_removeTopShadow
{
    self.layer.shadowOpacity = 0.0;
    self.layer.shadowColor = UIColor.clearColor.CGColor;
}

- (void)zzk_addTopBorder
{
    UIView *borderLine = [UIView zzk_newAutoLayoutView];
    borderLine.tag = kTopBorderTag;
    borderLine.backgroundColor = UIColor.lightGrayColor;
    [self addSubview:borderLine];
    
    [borderLine.heightAnchor constraintEqualToConstant:1.0].active = YES;
    [borderLine.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
    [borderLine.bottomAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [borderLine.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
}

- (void)zzk_removeTopBorder
{
    [[self viewWithTag:kTopBorderTag] removeFromSuperview];
}

#pragma mark - Background
#pragma mark -
- (void)zzk_addDimBackground
{
    [self zzk_removeDimBackground];
    
    [self addSubview:({
        UIView *background = [[UIView alloc] initWithFrame:self.bounds];
        background.tag = kDimBackgroundTag;
        background.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        background.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [background zzk_setAnimatedHidden:NO completion:nil];
        background;
    })];
}

- (void)zzk_removeDimBackground
{
    [[self viewWithTag:kDimBackgroundTag] removeFromSuperview];
}

#pragma mark - Corner Radius
#pragma mark -
- (void)zzk_setCornerRadius:(CGFloat)radius
{
    [self zzk_setCornerRadius:radius byRoundingCorners:UIRectCornerAllCorners];
}

- (void)zzk_setCornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color
{
    [self zzk_setCornerRadius:radius byRoundingCorners:UIRectCornerAllCorners borderWidth:width borderColor:color];
}

- (void)zzk_setCornerRadius:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners
{
    [self zzk_setCornerRadius:radius byRoundingCorners:corners borderWidth:0.0 borderColor:UIColor.clearColor];
}

- (void)zzk_setCornerRadius:(CGFloat)radius byRoundingCorners:(UIRectCorner)corners borderWidth:(CGFloat)width borderColor:(UIColor *)color
{
    CGSize cornerRadii = CGSizeMake(radius, radius);
    UIBezierPath *roundedPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    [roundedPath closePath];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = roundedPath.CGPath;
    maskLayer.borderWidth = width;
    maskLayer.lineJoin = kCALineJoinRound;
    maskLayer.borderColor = color.CGColor;
    self.layer.mask = maskLayer;
}

#pragma mark - Animation
#pragma mark -
+ (void)zzk_animateWithDefaultDuration:(ZZVoidBlockType)animations
{
    [UIView zzk_animateWithDefaultDuration:animations completion:nil];
}

+ (void)zzk_animateWithDefaultDuration:(ZZVoidBlockType)animations completion:(ZZBoolBlockType)completion
{
    [UIView animateWithDuration:CATransaction.animationDuration animations:animations completion:completion];
}

+ (void)zzk_animateSpringWithDefaultDuration:(ZZVoidBlockType)animations
{
    [UIView zzk_animateSpringWithDefaultDuration:animations completion:nil];
}

+ (void)zzk_animateSpringWithDefaultDuration:(ZZVoidBlockType)animations completion:(ZZBoolBlockType)completion
{
    [UIView animateWithDuration:[CATransaction animationDuration]
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:10
                        options:0
                     animations:animations
                     completion:completion];
}

- (void)zzk_animateSpringScale
{
    [UIView zzk_animateWithDefaultDuration:^{
        self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView zzk_animateSpringWithDefaultDuration:^{
            self.transform = CGAffineTransformIdentity;
        }];
    }];
}

- (void)zzk_setAnimatedHidden:(BOOL)hidden completion:(ZZVoidBlockType)completion
{
    if (!hidden) {
        self.hidden = hidden;
        self.alpha = 0.0;
    }
    
    [UIView zzk_animateWithDefaultDuration:^{
        self.alpha = hidden ? 0.0 : 1.0;
    } completion:^(BOOL finished) {
        self.alpha = 1.0;
        self.hidden = hidden;
        if (completion) completion();
    }];
}

@end
