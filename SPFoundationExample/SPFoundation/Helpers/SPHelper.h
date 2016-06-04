//
//  SPHelper.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/22.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "objc/runtime.h"

@interface SPHelper : NSObject

+ (UIViewController *)viewControllerForStoryboardName:(NSString*)storyboardName class:(id)class;

@end
