//
//  MainViewController.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/22.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "MainViewController.h"
#import "SXBarButton.h"
#import "SXTabBar.h"
#import "UIView+SPFoundation.h"

@interface MainViewController ()<SXTabBarDelegate>
@end

@implementation MainViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    SXTabBar *tabBar = [[SXTabBar alloc] init];
//    tabBar.frame = self.tabBar.bounds;
//    tabBar.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
//    [self.tabBar addSubview:tabBar];
//    
//    tabBar.delegate = self;
//    
//    [tabBar addImageView];
//    
//    [tabBar addBarButtonWithNorName:@"tabbar_icon_news_normal" andDisName:@"tabbar_icon_news_highlight" andTitle:@"新闻"];
//    [tabBar addBarButtonWithNorName:@"tabbar_icon_reader_normal" andDisName:@"tabbar_icon_reader_highlight" andTitle:@"阅读"];
//    [tabBar addBarButtonWithNorName:@"tabbar_icon_media_normal" andDisName:@"tabbar_icon_media_highlight" andTitle:@"视听"];
//    [tabBar addBarButtonWithNorName:@"tabbar_icon_found_normal" andDisName:@"tabbar_icon_found_highlight" andTitle:@"发现"];
//    [tabBar addBarButtonWithNorName:@"tabbar_icon_me_normal" andDisName:@"tabbar_icon_me_highlight" andTitle:@"我"];
//    
//    self.selectedIndex = 0;
}

#pragma mark - ******************** SXTabBarDelegate代理方法

- (void)ChangSelIndexForm:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
}

@end
