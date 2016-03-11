//
//  UIWindow+SPHierarchy.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (SPHierarchy)

- (UIViewController*) topMostController;

- (UIViewController*)currentViewController;

@end
