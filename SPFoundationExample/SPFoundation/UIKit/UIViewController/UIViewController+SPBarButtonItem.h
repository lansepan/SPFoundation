//
//  UIViewController+SPBarButtonItem.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/11.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SPBarButtonItem)

- (void)setNavTitle:(NSString *)title size:(CGFloat)size;

- (void)btnLeftItemAction:(id)sender;

- (void)btnRightItemAction:(id)sender;

- (void)setLeftNavItemWithTitle:(NSString *)title imageName:(NSString *)imageName;

- (void)setRightNavItemWithTitle:(NSString *)title imageName:(NSString *)imageName;

- (void)setLeftNavItemWithTitle:(NSString *)title size:(CGFloat)size imageName:(NSString *)imageName;

@end
