//
//  WelcomeView.m
//  SPFoundationExample
//
//  Created by BluePan on 16/7/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "WelcomeView.h"

#define screen_width  [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

@interface WelcomeView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollContent;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *arrayImgs;

@end

@implementation WelcomeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //添加手势
        UITapGestureRecognizer *singleRecognizer;
        singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTapFrom)];
        singleRecognizer.numberOfTapsRequired = 1;
        [self.scrollContent addGestureRecognizer:singleRecognizer];
    }
    return self;
}

- (void)setData:(NSArray *)imgs hidePage:(BOOL)hidePage
{
    self.arrayImgs = imgs;
    self.pageControl.hidden = hidePage;
    for(int i = 0; i < self.arrayImgs.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(i * screen_width, 0, screen_width, screen_height);
        UIImage *image = [UIImage imageNamed:self.arrayImgs[i]];
        imageView.image = image;
        [self.scrollContent addSubview:imageView];
    }
    self.scrollContent.contentSize = CGSizeMake((self.arrayImgs.count + 1)*screen_width, screen_height);
    self.pageControl.hidden = hidePage;
}

- (UIPageControl *)pageControl
{
    if(!_pageControl)
    {
        _pageControl= [[UIPageControl alloc]initWithFrame:CGRectMake(screen_width/2, screen_height - 60, 0, 40)];
        _pageControl.numberOfPages = self.arrayImgs.count;
        _pageControl.backgroundColor = [UIColor clearColor];
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

- (UIScrollView *)scrollContent
{
    if(!_scrollContent)
    {
        _scrollContent = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
        _scrollContent.pagingEnabled = YES;
        _scrollContent.bounces = NO;
        _scrollContent.showsHorizontalScrollIndicator = NO;
        _scrollContent.delegate = self;
        [self addSubview:_scrollContent];
    }
    return _scrollContent;
}

- (void)handleSingleTapFrom
{
    if(_pageControl.currentPage == 3)
    {
        self.hidden = YES;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollContent)
    {
        CGPoint offSet = scrollView.contentOffset;
        _pageControl.currentPage = offSet.x/(self.bounds.size.width);//计算当前的页码
        [scrollView setContentOffset:CGPointMake(self.bounds.size.width * (_pageControl.currentPage), scrollView.contentOffset.y) animated:YES];
    }
    if (scrollView.contentOffset.x == (self.arrayImgs.count)*screen_width)
    {
        self.hidden = YES;
    }
}

@end
