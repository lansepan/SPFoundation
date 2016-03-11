//
//  UIView+SPFoundation.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/7.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SPFoundation)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, readonly, assign) CGFloat screenX;
@property (nonatomic, readonly, assign) CGFloat screenY;
@property (nonatomic, readonly, assign) CGFloat screenViewX;
@property (nonatomic, readonly, assign) CGFloat screenViewY;

@property (nonatomic, readonly, assign) CGRect screenFrame;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

- (void)removeAllSubviews;
- (UIViewController *)viewController;
- (void)setRoundedCorners:(CGFloat)radius;
- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius;

@end
