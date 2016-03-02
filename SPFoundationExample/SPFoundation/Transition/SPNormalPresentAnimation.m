//
//  SPNormalPresentAnimation.m
//  SportsCool
//
//  Created by BluePan on 14/11/5.
//  Copyright (c) 2014年 Chengdu SportsCool Network Technology Inc. All rights reserved.
//

#import "SPNormalPresentAnimation.h"

@implementation SPNormalPresentAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.2;//动画切换时间
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //得到要切换的ViewController
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //要呈现的VC
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalFrame, 0,0);
    toVC.view.alpha = 0.0;
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    effectview.frame = toVC.view.frame;
    [toVC.view insertSubview:effectview atIndex:0];

    //将view添加到containerView中；
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    //动画显示
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];//在动画结束后必须向context报告VC切换完成
    }];
}

@end
