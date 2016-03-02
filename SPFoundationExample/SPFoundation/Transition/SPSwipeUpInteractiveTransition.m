//
//  SPSwipeUpInteractiveTransition.m
//  SportsCool
//
//  Created by BluePan on 14/10/31.
//  Copyright (c) 2014年 Chengdu SportsCool Network Technology Inc. All rights reserved.
//

#import "SPSwipeUpInteractiveTransition.h"

@interface SPSwipeUpInteractiveTransition()

@property (nonatomic, assign) BOOL shouldComplete;
@property (nonatomic, strong) UIViewController *presentingVC;

@end

@implementation SPSwipeUpInteractiveTransition

- (void)wireToViewController:(UIViewController *)viewController
{
    self.presentingVC = viewController;
    [self prepareGestureRecognizerInView:viewController.view];
}

- (void)prepareGestureRecognizerInView:(UIView *)view
{
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:gesture];
}

- (CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    switch (gestureRecognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            //手势开始
            self.interacting = YES;
            [self.presentingVC dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged:
        {
            //计算百分比，设定了向下划动400像素或以上为100%，每次手势状态变化时根据当前手势位置计算新的百分比，结果被限制在0～1之间。
            CGFloat fraction = translation.y / 400.0;
            fraction = fminf(fmaxf(fraction, 0.0), 1.0);
            self.shouldComplete = (fraction > 0.5);
            [self updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            // 3. 手势结束时，手势距离超过设定一半就认为应该结束手势，否则就应该返回原来状态
            self.interacting = NO;
            if (!self.shouldComplete || gestureRecognizer.state == UIGestureRecognizerStateCancelled)
            {
                [self cancelInteractiveTransition];
            }
            else
            {
                [self finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

@end
