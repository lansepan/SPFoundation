//
//  SPSegmentControll.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/11.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "SPSegmentControll.h"

#define DefaultCurrentBtnColor [UIColor grayColor]

@interface SPSegmentControll()

@property NSUInteger btnCount;
@property CGFloat btnWidth;
@property BOOL ifSelectedBegan;
@property (nonatomic, strong) UIButton *currentBtn;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation SPSegmentControll

@synthesize indicatorViewColor = _indicatorViewColor;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray
{
    if (self = [super initWithFrame:frame])
    {
        self.layer.cornerRadius = frame.size.height / 10;
        self.layer.masksToBounds = YES;
        self.titleArray = titleArray;
        self.btnCount = titleArray.count;
        [self loadSubViews];
    }
    return self;
}

- (NSMutableArray *)buttonArray
{
    if (_buttonArray == nil)
    {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (void)setIndicatorViewColor:(UIColor *)indicatorViewColor
{
    self.indicatorView.backgroundColor = indicatorViewColor;
    for (UIButton *btn in self.buttonArray)
    {
        if (self.currentBtn != btn)
        {
            [btn setTitleColor:self.indicatorViewColor forState:UIControlStateNormal];
            [btn setTitleColor:self.indicatorViewColor forState:UIControlStateHighlighted];
        }
    }
}

- (UIColor *)indicatorViewColor
{
    if (_indicatorViewColor == nil)
    {
        _indicatorViewColor = [UIColor whiteColor];
    }
    return _indicatorViewColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    [self.currentBtn setTitleColor:backgroundColor forState:UIControlStateNormal];
}

- (void)loadSubViews
{
    self.btnWidth = self.frame.size.width / self.btnCount;
    CGFloat btnHeight = self.frame.size.height;
    
    //创建白色指示块
    self.indicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.btnWidth+1.f, btnHeight)];
    self.indicatorView.backgroundColor = self.indicatorViewColor;
    self.indicatorView.layer.cornerRadius = self.layer.cornerRadius;
    self.indicatorView.layer.masksToBounds = YES;
    [self addSubview:self.indicatorView];
    
    //创建按钮
    for (int i = 0; i < self.titleArray.count; i ++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.btnWidth * i, 0, self.btnWidth, btnHeight);
        [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.buttonArray addObject:btn];
    }
    self.currentBtn = self.buttonArray[0];
    [self.currentBtn setTitleColor:DefaultCurrentBtnColor forState:UIControlStateNormal];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint p = [self convertPoint:point toView:self.indicatorView];
    if ([self.indicatorView pointInside:p withEvent:event])
    {
        return self;
    }
    else
    {
        return [super hitTest:point withEvent:event];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self selecteBegan];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGPoint prevP = [touch previousLocationInView:self];
    CGFloat delta = point.x - prevP.x; // 手势改变的x范围
    CGRect frame = self.indicatorView.frame;
    
    // 限制indicatorView的滑动范围
    if (frame.origin.x + delta >= 0 && frame.origin.x + delta <= (self.btnCount - 1) * self.btnWidth)
    {
        frame.origin = CGPointMake(frame.origin.x + delta, 0);
    }
    CGFloat persent = self.indicatorView.frame.origin.x / (self.btnCount * self.btnWidth);
    if ([self.delegate respondsToSelector:@selector(segmentControl:didScrolledPersent:)])
    {
        [self.delegate segmentControl:self didScrolledPersent:persent];
    }
    self.indicatorView.frame = frame;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint center = self.indicatorView.center;
    NSInteger index = (NSInteger)center.x / self.btnWidth;
    [self setSelectedIndex:index];
}

- (void)btnClicked:(UIButton *)btn
{
    NSInteger index = (NSInteger)btn.frame.origin.x / self.btnWidth;
    [self setSelectedIndex:index];
}

- (void)setSelectedIndex:(NSInteger)index
{
    // 告诉代理选中了哪个按钮
    [self selecteBegan]; // 选中开始的设置
    self.currentBtn = self.buttonArray[index];
    [UIView animateWithDuration:0.25f animations:^{
        self.indicatorView.frame = CGRectMake(self.btnWidth * index, 0, self.indicatorView.frame.size.width, self.indicatorView.frame.size.height);
    } completion:^(BOOL finished) {
        [self selectEnd]; // 选中结束的设置
        //该方法为模拟
        if ([self.delegate respondsToSelector:@selector(segmentControl:didSelectedIndex:)]) {
            [self.delegate segmentControl:self didSelectedIndex:index];
        }
    }];
}

- (void)selecteBegan
{
    if (self.ifSelectedBegan) return;
    self.ifSelectedBegan = YES;
    self.indicatorView.alpha = 0.5f;
    [self.currentBtn setTitleColor:self.indicatorViewColor forState:UIControlStateNormal];
}

- (void)selectEnd
{
    if (!self.ifSelectedBegan) return;
    self.ifSelectedBegan = NO;
    self.indicatorView.alpha = 1.f;
    UIColor *color = self.backgroundColor ? self.backgroundColor : DefaultCurrentBtnColor;
    [self.currentBtn setTitleColor:color forState:UIControlStateNormal];
}

@end
