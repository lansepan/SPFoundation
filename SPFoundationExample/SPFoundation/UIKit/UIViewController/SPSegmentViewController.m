//
//  SPSegmentViewController.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/11.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "SPSegmentViewController.h"
#import "SPSegmentControll.h"

@interface SPSegmentViewController ()<UIScrollViewDelegate,SPSegmentControllDelegate>
{
    CGFloat vcWidth;  //每个子视图控制器的视图的宽
    CGFloat vcHeight; //每个子视图控制器的视图的高
    SPSegmentControll *segment;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation SPSegmentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.segmentBgColor = [UIColor colorWithRed:207.0f/255 green:37.0f/255 blue:42.0f/255 alpha:1.0f];
    self.indicatorViewColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupScrollView];
    [self setupViewControllers];
    [self setupSegmentControl];
}

- (CGFloat)itemWidth
{
    if (_itemWidth == 0)
    {
        _itemWidth = 50.0f;
    }
    return _itemWidth;
}

- (void)setupScrollView
{
    CGFloat Y = 0.0f;
    if (self.navigationController != nil && ![self.navigationController isNavigationBarHidden])
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
        Y = 64.0f;
    }
    vcWidth = self.view.frame.size.width;
    vcHeight = self.view.frame.size.height - Y;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, Y, vcWidth, vcHeight)];
    scrollView.contentSize = CGSizeMake(vcWidth * self.viewControllerArray.count, vcHeight);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator   = NO;
    //该属性设置为yes，可支持滑动换页
    scrollView.scrollEnabled = NO;
    scrollView.pagingEnabled  = YES;
    scrollView.delegate      = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)setupViewControllers
{
    for (int i = 0; i < self.viewControllerArray.count; i++)
    {
        UIViewController *vc = self.viewControllerArray[i];
        [self addChildViewController:vc];
        vc.view.frame = CGRectMake(vcWidth * i, 0, vcWidth, vcHeight);
        [self.scrollView addSubview:vc.view];
    }
}

- (void)setupSegmentControl
{
    segment = [[SPSegmentControll alloc] initWithFrame:CGRectMake(0, 0, self.itemWidth * self.viewControllerArray.count, 25) titles:self.titleArray];
    segment.backgroundColor = self.segmentBgColor;
    segment.indicatorViewColor = self.indicatorViewColor;
    segment.delegate = self;
    self.navigationItem.titleView = segment;
}

#pragma mark UIScrollViewDelegate

// 这个方法是手动拖动滚动视图停止后才会调用，在外部通过setContentOffset改变的不会调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / vcWidth;
    [segment setSelectedIndex:index];
}

#pragma mark SPSegmentControllDelegate

- (void)segmentControl:(SPSegmentControll *)segment didSelectedIndex:(NSInteger)index
{
    CGPoint offset = CGPointMake(vcWidth * index, 0);
    [self.scrollView setContentOffset:offset animated:NO];
}

@end
