//
//  UIViewController+SPBarButtonItem.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/11.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "UIViewController+SPBarButtonItem.h"

@implementation UIViewController (SPBarButtonItem)

- (void)setNavTitle:(NSString *)title size:(CGFloat)size
{
    UIButton *midButton = [UIButton buttonWithType:UIButtonTypeCustom];
    midButton.titleLabel.font = [UIFont systemFontOfSize:size];
    [midButton setTitle:title forState:UIControlStateNormal];
    midButton.frame = CGRectMake(0, 0, 100, 40);
    self.navigationItem.titleView = midButton;
}

- (void)setLeftNavItemWithTitle:(NSString *)title imageName:(NSString *)imageName
{
    if(imageName)
    {
        UIImage *leftImage = [UIImage imageNamed:imageName];
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setImage:leftImage forState:UIControlStateNormal];
        leftButton.frame = CGRectMake(0, 0, leftImage.size.width, leftImage.size.height);
        [leftButton addTarget:self action:@selector(btnLeftItemAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        self.navigationItem.leftBarButtonItem = leftItem;
        return;
    }
    if(title)
    {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(btnLeftItemAction:)];
        self.navigationItem.leftBarButtonItem = leftItem;
        return;
    }
}

- (void)setLeftNavItemWithTitle:(NSString *)title size:(CGFloat)size imageName:(NSString *)imageName
{
    if(imageName)
    {
        UIImage *leftImage = [UIImage imageNamed:imageName];
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setImage:leftImage forState:UIControlStateNormal];
        leftButton.frame = CGRectMake(0, 0, leftImage.size.width, leftImage.size.height);
        [leftButton addTarget:self action:@selector(btnLeftItemAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        self.navigationItem.leftBarButtonItem = leftItem;
        return;
    }
    if(title)
    {
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:size];
        [leftButton setTitle:title forState:UIControlStateNormal];
        leftButton.frame = CGRectMake(0, 0, 50, 30);
        [leftButton addTarget:self action:@selector(btnLeftItemAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        self.navigationItem.leftBarButtonItem = leftItem;
        return;
    }
}

- (void)setRightNavItemWithTitle:(NSString *)title imageName:(NSString *)imageName
{
    if(imageName)
    {
        UIImage *rightImage = [UIImage imageNamed:imageName];
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setImage:rightImage forState:UIControlStateNormal];
        rightButton.frame = CGRectMake(0, 0, rightImage.size.width, rightImage.size.height);
        [rightButton addTarget:self action:@selector(btnRightItemAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        self.navigationItem.rightBarButtonItem = rightItem;
        return;
    }
    if(title)
    {
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(btnRightItemAction:)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}

- (void)btnLeftItemAction:(id)sender
{
    
}

- (void)btnRightItemAction:(id)sender
{
    
}

@end
