//
//  SPNormalDismissAnimation.m
//  SportsCool
//
//  Created by BluePan on 14/10/31.
//  Copyright (c) 2014年 Chengdu SportsCool Network Technology Inc. All rights reserved.
//

#import "SPNormalDismissAnimation.h"

@implementation SPNormalDismissAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;//动画切换时间
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //CGRect screenBounds = [[UIScreen mainScreen] bounds];
    //CGRect initFrame = [transitionContext initialFrameForViewController:fromVC];
    //CGRect finalFrame = CGRectOffset(initFrame, 0, screenBounds.size.height);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView sendSubviewToBack:toVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
