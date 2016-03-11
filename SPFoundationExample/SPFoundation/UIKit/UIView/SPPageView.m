//
//  SPPageView.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "SPPageView.h"
#import "TAPageControl.h"
#import <SDWebImage/UIButton+WebCache.h>

@interface SPPageView()<UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger idx;
@property (nonatomic, copy) NSArray *arrayImg;
@property (nonatomic, strong) UIScrollView *scrollContent;
@property (nonatomic, strong) UIButton *btnPrev,*btnCur,*btnNext;
@property (nonatomic, strong) TAPageControl *page;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) AdPageClickBlock callBlock;

@end

@implementation SPPageView

- (void)dealloc
{
    [self stopTimerPlay];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initUI];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self initUI];
}

- (void)initUI
{
    self.scrollContent = [[UIScrollView alloc] initWithFrame:self.frame];
    self.scrollContent.delegate = self;
    self.scrollContent.pagingEnabled = YES;
    self.scrollContent.bounces = NO;
    self.scrollContent.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
    self.scrollContent.showsHorizontalScrollIndicator = NO;
    self.scrollContent.showsVerticalScrollIndicator = NO;
    [self.scrollContent setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self addSubview:self.scrollContent];
    
    self.btnPrev = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnPrev.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.btnPrev.contentMode = UIViewContentModeScaleAspectFill;
    self.btnPrev.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.btnPrev addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnCur = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnCur.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.btnCur.contentMode = UIViewContentModeScaleAspectFill;
    self.btnCur.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    [self.btnCur addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnNext.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.btnNext.contentMode = UIViewContentModeScaleAspectFill;
    self.btnNext.frame = CGRectMake(2*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    [self.btnNext addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollContent addSubview:self.btnPrev];
    [self.scrollContent addSubview:self.btnCur];
    [self.scrollContent addSubview:self.btnNext];
    
    self.page = [[TAPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-15,self.frame.size.width,0)];
    self.page.hidesForSinglePage = YES;
    self.page.dotImage = [UIImage imageNamed:@"icon_dot"];
    self.page.currentDotImage = [UIImage imageNamed:@"icon_star"];
    [self addSubview:self.page];
}

//启动函数
- (void)startAdsWithBlock:(NSArray *)imageArray block:(AdPageClickBlock)block
{
    if(imageArray.count <= 1)
    {
        self.scrollContent.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    }
    self.page.numberOfPages = imageArray.count;
    self.arrayImg = imageArray;
    self.callBlock = [block copy];
    [self reloadImages];
}

//加载图片顺序
- (void)reloadImages
{
    if (self.idx >= (int)self.arrayImg.count) self.idx = 0;
    if (self.idx < 0) self.idx = (int)self.arrayImg.count - 1;
    
    NSInteger prev = self.idx - 1;
    if (prev < 0) prev = (int)self.arrayImg.count - 1;
    NSInteger next = self.idx + 1;
    if (prev<0) prev = 0;
    if (next > self.arrayImg.count - 1) next = 0;
    
    self.page.currentPage = self.idx;
    
    if (self.arrayImg.count>0)
    {
        NSString *placeholder = @"default_h_l";
        NSString *strPrev = [self.arrayImg objectAtIndex:prev];
        NSString *strCur = [self.arrayImg objectAtIndex:self.idx];
        NSString *strNext = [self.arrayImg objectAtIndex:next];
        
        [self.btnPrev sd_setBackgroundImageWithURL:[NSURL URLWithString:strPrev] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:placeholder] options:SDWebImageRetryFailed];
        [self.btnCur sd_setBackgroundImageWithURL:[NSURL URLWithString:strCur] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:placeholder] options:SDWebImageRetryFailed];
        [self.btnNext sd_setBackgroundImageWithURL:[NSURL URLWithString:strNext] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:placeholder] options:SDWebImageRetryFailed];
        
        [self.scrollContent scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
        
        [self startTimerPlay];
    }
}

- (IBAction)btnClickAction:(id)sender
{
    if(self.callBlock && self.arrayImg.count>0)
    {
        self.callBlock(self.idx);
    }
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.timer) [self.timer invalidate];
    
    if (scrollView.contentOffset.x >=self.frame.size.width*2)
        self.idx++;
    else if (scrollView.contentOffset.x < self.frame.size.width)
        self.idx--;
    [self reloadImages];
}

- (void)startTimerPlay
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(doImageGoDisplay) userInfo:nil repeats:NO];
}

- (void)stopTimerPlay
{
    if(self.timer)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
}

//轮播图片
- (void)doImageGoDisplay
{
    [UIView animateWithDuration:.5 animations:^{
        [self.scrollContent scrollRectToVisible:CGRectMake(self.frame.size.width * 2, 0, self.frame.size.width, self.frame.size.height) animated:NO];
    }];
    
    self.idx++;
    [self performSelector:@selector(reloadImages) withObject:nil afterDelay:0.3];
}

@end
