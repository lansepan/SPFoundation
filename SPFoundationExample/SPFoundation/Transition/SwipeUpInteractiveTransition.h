//
//  SwipeUpInteractiveTransition.h
//  SportsCool
//
//  Created by BluePan on 14/10/31.
//  Copyright (c) 2014年 Chengdu SportsCool Network Technology Inc. All rights reserved.
//

//自定义交互式切换类
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface SwipeUpInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interacting;//是否处于切换过程中

- (void)wireToViewController:(UIViewController*)viewController;

@end
