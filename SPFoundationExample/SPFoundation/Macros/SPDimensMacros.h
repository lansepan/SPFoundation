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

#define BOTTOM_BAR_HEIGHT        (49.f)

//状态栏＋导航栏 高度
#define STATUS_AND_NAVIGATION_HEIGHT ((STATUS_BAR_HEIGHT) + (NAVIGATION_BAR_HEIGHT))

#define APP_RECT [[UIScreen mainScreen] applicationFrame]

#define APP_HEIGHT [[UIScreen mainScreen] applicationFrame].size.height

#define APP_WIDTH [[UIScreen mainScreen] applicationFrame].size.width

#define SCREEN_RECT ([UIScreen mainScreen].bounds)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define CONTENT_HEIGHT (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)

//屏幕分辨率
#define SCREEN_RESOLUTION (SCREEN_WIDTH * SCREEN_HEIGHT * ([UIScreen mainScreen].scale))

//不同设备的屏幕比例
#define SCREEN_SCALE ((SCREEN_HEIGHT > 568) ? SCREEN_HEIGHT/568 : 1)

#define SCALE_RATIO (SCREEN_WIDTH/414.0)

#define SCALE_RATIO_414 (SCREEN_WIDTH/414.0)

#define SCALE_RATIO_320 (SCREEN_WIDTH/320.0)

#define SCALE_RATIO_375 (SCREEN_WIDTH/375.0)

#define SCALE_RATIO_414 (SCREEN_WIDTH/414.0)

// View 坐标(x,y)和宽高(width,height)
#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y

#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height

#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)

#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)

@interface SPDimensMacros : NSObject

@end

