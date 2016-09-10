//
//  UIView+SPFoundation.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/7.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "UIView+SPFoundation.h"

#import <objc/runtime.h>

CGPoint CGRectGetCenter(CGRect rect) {
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center) {
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x - CGRectGetMidX(rect);
    newrect.origin.y = center.y - CGRectGetMidY(rect);
    newrect.size = rect.size;
    return newrect;
}

@implementation UIView (SPFoundation)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)screenX
{
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview)
    {
        x += view.left;
    }
    return x;
}

- (CGFloat)screenY
{
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview)
    {
        y += view.top;
    }
    return y;
}

- (CGFloat)screenViewX
{
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview)
    {
        x += view.left;
        if ([view isKindOfClass:[UIScrollView class]])
        {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}

- (CGFloat)screenViewY
{
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview)
    {
        y += view.top;
        if ([view isKindOfClass:[UIScrollView class]])
        {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}

- (CGRect)screenFrame
{
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)removeAllSubviews
{
    while (self.subviews.count)
    {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (UIViewController *)viewController
{
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
    {
        return (UIViewController *)nextResponder;
    }
    else
    {
        return nil;
    }
}

- (void)setRoundedCorners:(CGFloat)radius
{
    CALayer *maskLayer = [CALayer layer];
    maskLayer.cornerRadius = radius;
    maskLayer.backgroundColor = [UIColor blackColor].CGColor;
    maskLayer.frame = self.bounds;
    self.layer.mask = maskLayer;
}

- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius
{
    CGRect rect = self.bounds;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect  byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

// Move via offset
- (void)moveBy:(CGPoint)delta {
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

// Scaling
- (void)scaleBy:(CGFloat)scaleFactor {
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void)fitInSize:(CGSize)aSize {
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height)) {
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width)) {
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;
}

- (CGFloat)radius
{
    return self.layer.cornerRadius;
}

- (void)setRadius:(CGFloat)radius
{
    if (radius <= 0) {
        radius = self.width * 0.5f;
    }
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

//变圆
- (UIView *)roundV {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.width / 2;
    return self;
}

//加阴影
- (void)addShadow {
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowOpacity = 0.24;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, self.height - 2, self.width == 320 ? [UIScreen mainScreen].bounds.size.width : self.width, 2)].CGPath;
}

//单点击手势
- (void)tapGesture_T:(id)target S:(SEL)action {
    UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:TapGesture];
}
/** 添加边框:四边 */
- (void)border:(UIColor *)color width:(CGFloat)width CornerRadius:(CGFloat)radius {
    if (radius == 0) {
        [self border:color width:width];
    } else {
        CALayer *layer = self.layer;
        if (color != nil) {
            layer.borderColor = color.CGColor;
        }
        layer.cornerRadius = radius;
        layer.masksToBounds = YES;
        layer.borderWidth = width;
    }
}
/** 四边变圆 */
- (void)borderRoundCornerRadius:(CGFloat)radius {
    CALayer *layer = self.layer;
    
    layer.cornerRadius = radius;
    layer.masksToBounds = YES;
}
//添加边框
- (void)border:(UIColor *)color width:(CGFloat)width;
{
    CALayer *layer = self.layer;
    if (color != nil) {
        layer.borderColor = color.CGColor;
    }
    layer.cornerRadius = 4;
    layer.masksToBounds = YES;
    layer.borderWidth = width;
}

- (void)borderRound {
    CALayer *layer = self.layer;
    layer.cornerRadius = 4;
    layer.masksToBounds = YES;
}

/** 移除对应的view */
- (void)removeClassView:(Class)classV {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:classV]) {
            [view removeFromSuperview];
        }
    }
}

//调试
- (void)debug:(UIColor *)color width:(CGFloat)width {
#ifdef DEBUG
    if (color == nil) {
        [self border:[UIColor colorWithRed:(arc4random() % 255) / 255.0f green:(arc4random() % 255) / 255.0f blue:(arc4random() % 255) / 255.0f alpha:1] width:width];
        return;
    }
    [self border:color width:width];
#endif
}

static char kActionHandlerTapBlockKey;
static char kActionHandlerTapGestureKey;
static char kActionHandlerLongPressBlockKey;
static char kActionHandlerLongPressGestureKey;

//单点击手势
- (void)tapGesture:(GestureActionBlock)block {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForTapGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
        if (block) {
            block(gesture);
        }
    }
}

//长按手势
- (void)longPressGestrue:(GestureActionBlock)block {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerLongPressGestureKey);
    if (!gesture) {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForLongPressGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerLongPressBlockKey);
        if (block) {
            block(gesture);
        }
    }
}

//画线
+ (CAShapeLayer *)drawLine:(CGPoint)points to:(CGPoint)pointe color:(UIColor *)color {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:points];
    [path addLineToPoint:pointe];
    [path closePath];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [color CGColor];
    shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
    shapeLayer.lineWidth = 1;
    return shapeLayer;
}

//画框框线
+ (CAShapeLayer *)drawRect:(CGRect)rect radius:(CGFloat)redius color:(UIColor *)color {
    CAShapeLayer *solidLine = [CAShapeLayer layer];
    UIBezierPath *solidPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:redius];
    solidLine.lineWidth = 1.0f;
    solidLine.strokeColor = color.CGColor;
    solidLine.fillColor = [UIColor clearColor].CGColor;
    solidLine.path = solidPath.CGPath;
    return solidLine;
}

//画圆
+ (CAShapeLayer *)drawArc:(CGPoint)points radius:(CGFloat)radius startD:(CGFloat)startd endD:(CGFloat)endD color:(UIColor *)color {
    CAShapeLayer *solidLine = [CAShapeLayer layer];
    UIBezierPath *solidPath = [UIBezierPath bezierPathWithArcCenter:points radius:radius startAngle:startd endAngle:endD clockwise:YES];
    solidLine.lineWidth = 1.0f;
    solidLine.strokeColor = color.CGColor;
    solidLine.fillColor = [UIColor clearColor].CGColor;
    solidLine.path = solidPath.CGPath;
    return solidLine;
}

@end
