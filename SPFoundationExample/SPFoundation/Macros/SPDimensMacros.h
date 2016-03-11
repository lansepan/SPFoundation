//
//  DimensMacros.h
//  JingYaSiTing
//
//  Created by BluePan on 16/2/26.
//  Copyright © 2016年 中联苹果实验室. All rights reserved.
//

#import <Foundation/Foundation.h>

//状态栏高度
#define STATUS_BAR_HEIGHT 20

//NavBar高度
#define NAVIGATION_BAR_HEIGHT 44

//状态栏＋导航栏 高度
#define STATUS_AND_NAVIGATION_HEIGHT ((STATUS_BAR_HEIGHT) + (NAVIGATION_BAR_HEIGHT))

#define SCREEN_RECT ([UIScreen mainScreen].bounds)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define CONTENT_HEIGHT (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)

//屏幕分辨率
#define SCREEN_RESOLUTION (SCREEN_WIDTH * SCREEN_HEIGHT * ([UIScreen mainScreen].scale))

@interface SPDimensMacros : NSObject

@end

