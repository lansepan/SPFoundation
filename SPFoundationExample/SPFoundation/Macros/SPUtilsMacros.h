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

#define WeakSelf __weak typeof(self) weakSelf = self;

@interface SPUtilsMacros : NSObject

@end

