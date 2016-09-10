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

- (void)moveBy:(CGPoint)delta;
- (void)scaleBy:(CGFloat)scaleFactor;
- (void)fitInSize:(CGSize)aSize;
/** 获取View所在的控制器 */
- (UIViewController *)viewController;

#pragma mark - 其它的效果😎

/** 变圆 */
- (UIView *)roundV;
/**  加阴影 self.layer.shadowOffset = CGSizeMake(0, 2)self.layer.shadowOpacity = 0.2; */
- (void)addShadow;

typedef void (^GestureActionBlock)(UIGestureRecognizer *ges);
/** 单点击手势 */
- (void)tapGesture:(GestureActionBlock)block;
/** 长按手势 */
- (void)longPressGestrue:(GestureActionBlock)block;

/** 添加边框:四边 */
- (void)border:(UIColor *)color width:(CGFloat)width CornerRadius:(CGFloat)radius;
/** 添加边框:四边 默认4*/
- (void)border:(UIColor *)color width:(CGFloat)width;
/** 四边变圆 */
- (void)borderRoundCornerRadius:(CGFloat)radius;
/** 四边变圆 默认4*/
- (void)borderRound;

- (void)debug:(UIColor *)color width:(CGFloat)width;
/** 移除对应的view */
- (void)removeClassView:(Class)classV;

/** 画线 */
+ (CAShapeLayer *)drawLine:(CGPoint)points to:(CGPoint)pointe color:(UIColor *)color;

/** 画框框线 */
+ (CAShapeLayer *)drawRect:(CGRect)rect radius:(CGFloat)redius color:(UIColor *)color;

/** 画圆 */
+ (CAShapeLayer *)drawArc:(CGPoint)points radius:(CGFloat)radius startD:(CGFloat)startd endD:(CGFloat)endD color:(UIColor *)color;

@end
