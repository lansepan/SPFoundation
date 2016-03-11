//
//  UIWindow+SPHierarchy.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "UIWindow+SPHierarchy.h"

@implementation UIWindow (SPHierarchy)

- (UIViewController*) topMostController
{
    UIViewController *topController = [self rootViewController];
    while ([topController presentedViewController])	topController = [topController presentedViewController];
    return topController;
}

- (UIViewController*)currentViewController;
{
    UIViewController *currentViewController = [self topMostController];
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    return currentViewController;
}

@end
