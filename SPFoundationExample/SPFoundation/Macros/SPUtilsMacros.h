//
//  UtilsMacros.h
//  JingYaSiTing
//
//  Created by BluePan on 16/2/26.
//  Copyright © 2016年 中联苹果实验室. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIDevice+SPIdentifierAddition.h"

#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define CURRENT_LANGUAGE ([[NSLocale preferredLanguages] objectAtIndex:0])//当前语言

#define RGB_COLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]//RGB颜色转换
#define RGBA_COLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]//ARGB颜色转换
#define RANDOM_COLOR [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]//随机颜色
#define UICOLOR_FROM_RGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define IS_IPHONE_4_OR_LESS ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height<568.0))
#define IS_IPHONE_5 ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height-568.0)?NO:YES)
#define IS_IPHONE_6 ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height-667.0)?NO:YES)
#define IS_IPHONE_6P ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height-736.0)?NO:YES)

//>=IOS7设备ID :b6bbf65ae4b470d102380cf80cbb820e28e7ee7f 注：获取UUID+bundleIdentifier（从keyChain中取，如果不存在，创建新的）
#define DEVICE_ID [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] uuidDeviceIdentifier]]
#define DEVICE_MODEL [NSString stringWithFormat:@"%@",[UIDevice currentDevice].model]//设备型号 :ipad iphone ipod ，加上了4.1、4.2等后缀
#define DEVICE_OS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])//iOS版本
#define DEVICE_OS_NAME [NSString stringWithFormat:@"%@",[UIDevice currentDevice].systemName]//系统名称 :iPhone OS
//#define DEVICE_OS_VERSION [NSString stringWithFormat:@"%@",[UIDevice currentDevice].systemVersion]//设备系统版本号 :5.0.1

#define APP_NAME [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]]//AppName :DoctorStation
#define APP_DISPLAYNAME NSLocalizedString(@"CFBundleDisplayName",@"")
#define APP_VERSION [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]//AppVersion :Build
#define APP_BUNDLE_IDENTIFIER [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]]//com.zlsoft.xx

//大于等于7.0的ios版本
#define iOS7_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
//大于等于8.0的ios版本
#define iOS8_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")

//角度转弧度
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

#define appDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

//当前App状态
#define IN_BACKEND ([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground)

#pragma mark - 创建单例
//单例定义
#define SHARED_INSTANCE + (instancetype)sharedInstance;

//单例实现
#ifndef SHARED_IMPLEMENT
#define SHARED_IMPLEMENT(InstanceName) \
+ (instancetype)sharedInstance \
{   \
static InstanceName * sharedInstance; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
sharedInstance = [[InstanceName alloc] init]; \
}); \
return sharedInstance;\
}
#endif

#ifdef DEBUG
#define BLLog(format, ...)             NSLog(format, ## __VA_ARGS__)
#else
#define BLLog(format, ...)
#endif

#define WeakSelf __weak typeof(self) weakSelf = self;

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


#pragma mark - KVO
#define ADDKVO(obj, obs, key) [obj addObserver:obs forKeyPath:key options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];

#define REMOVEKVO(obj, obs, key) [obj removeObserver:obs forKeyPath:key context:nil];

//是否为空或是[NSNull null]
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))

#pragma mark - 释放

#if !__has_feature(objc_arc)

/*safe release*/
#undef TT_RELEASE_SAFELY
#define TT_RELEASE_SAFELY(__REF) \
{\
if (nil != (__REF)) \
{\
CFRelease(__REF); \
__REF = nil;\
}\
}

//view安全释放
#undef TTVIEW_RELEASE_SAFELY
#define TTVIEW_RELEASE_SAFELY(__REF) \
{\
if (nil != (__REF))\
{\
[__REF removeFromSuperview];\
CFRelease(__REF);\
__REF = nil;\
}\
}

//释放定时器
#undef TT_INVALIDATE_TIMER
#define TT_INVALIDATE_TIMER(__TIMER) \
{\
[__TIMER invalidate];\
[__TIMER release];\
__TIMER = nil;\
}

#else

/*safe release*/
#undef TT_RELEASE_SAFELY
#define TT_RELEASE_SAFELY(__REF) \
{\
if (nil != (__REF)) \
{\
__REF = nil;\
}\
}

//view安全释放
#define TTVIEW_RELEASE_SAFELY(__REF) \
{\
if (nil != (__REF))\
{\
[__REF removeFromSuperview];\
__REF = nil;\
}\
}

//释放定时器
#define TT_INVALIDATE_TIMER(__TIMER) \
{\
[__TIMER invalidate];\
__TIMER = nil;\
}

#endif

@interface SPUtilsMacros : NSObject

@end

