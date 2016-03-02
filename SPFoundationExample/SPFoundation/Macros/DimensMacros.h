//
//  DimensMacros.h
//  JingYaSiTing
//
//  Created by BluePan on 16/2/26.
//  Copyright © 2016年 中联苹果实验室. All rights reserved.
//

//状态栏高度
#define STATUS_BAR_HEIGHT 20

//NavBar高度
#define NAVIGATION_BAR_HEIGHT 44

//状态栏 ＋ 导航栏 高度
#define STATUS_AND_NAVIGATION_HEIGHT ((STATUS_BAR_HEIGHT) + (NAVIGATION_BAR_HEIGHT))

#define SCREEN_RECT ([UIScreen mainScreen].bounds)

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)//界面宽度

#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)//界面高度

#define kScreenPixelWidth ([[UIScreen mainScreen] currentMode].size.width)//界面像素宽度

#define kScreenPixelHeight ([[UIScreen mainScreen] currentMode].size.height)//界面像素高度

#define CONTENT_HEIGHT (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)

//屏幕分辨率
#define SCREEN_RESOLUTION (SCREEN_WIDTH * SCREEN_HEIGHT * ([UIScreen mainScreen].scale))

#define BANNER_HEIGHT 215
#define STYLEPAGE_HEIGHT 21
#define SMALLTV_HEIGHT 77
#define SMALLTV_WIDTH 110
#define FOLLOW_HEIGHT 220
#define SUBCHANNEL_HEIGHT 62
