//
//  BouncePresentAnimation.m
//  SportsCool
//
//  Created by BluePan on 14/10/31.
//  Copyright (c) 2014年 Chengdu SportsCool Network Technology Inc. All rights reserved.
//

#import "BouncePresentAnimation.h"

@implementation BouncePresentAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;//动画切换时间
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //得到要切换的ViewController
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //对于要呈现的VC，从屏幕下方出现，因此将初始位置设置到屏幕下边缘；
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);
    
    //将view添加到containerView中；
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    //usingSpringWithDamping是iOS7新加入的，一个模拟弹簧动作的动画曲线
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0.0 usingSpringWithDamping:0.85 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        toVC.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];//在动画结束后必须向context报告VC切换完成
    }];
}

@end
