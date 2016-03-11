//
//  SPTabBar.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "SPTabBar.h"

@interface SPTabBar()

@property (nonatomic, strong) SPBarButton *selBtn;
@property (nonatomic, strong) UIImageView *imgBg;

@end

@implementation SPTabBar

- (void)addImgBg:(UIImage *)img
{
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = img;
    self.imgBg = imgView;
    [self addSubview:imgView];
}

- (void)addBarButton:(NSString *)normalImg disabledImg:(NSString *)disabledImg normalColor:(UIColor *)normalColor disabledColor:(UIColor *)disabledColor title:(NSString *)title
{
    SPBarButton *btn = [[SPBarButton alloc] init];
    
    [btn setImage:[UIImage imageNamed:normalImg] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:disabledImg] forState:UIControlStateDisabled];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:normalColor forState:UIControlStateNormal];
    [btn setTitleColor:disabledColor forState:UIControlStateDisabled];
    [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
    
    if (self.subviews.count == 2)
    {
        btn.tag = 1;
        [self btnClickAction:btn];
    }
}

- (void)btnClickAction:(id)sender
{
    SPBarButton *btn = (SPBarButton *)sender;
    if(self.delegate && [self.delegate respondsToSelector:@selector(spTabBar:didSelectItem:)])
    {
        [self.delegate spTabBar:self didSelectItem:btn];
    }
    self.selBtn.enabled = YES;
    self.selBtn = btn;
    btn.enabled = NO;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    UIImageView *imgView = self.subviews[0];
    imgView.frame = self.bounds;
    for (int i = 1; i<self.subviews.count; i++)
    {
        UIButton *btn = self.subviews[i];
        CGFloat btnW = [UIScreen mainScreen].bounds.size.width/5;
        CGFloat btnH = 49;
        CGFloat btnX = (i-1)*btnW;
        CGFloat btnY = 0;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.tag = i-1;
    }
}

@end
