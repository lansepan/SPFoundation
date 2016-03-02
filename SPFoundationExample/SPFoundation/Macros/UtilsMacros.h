//
//  UtilsMacros.h
//  JingYaSiTing
//
//  Created by BluePan on 16/2/26.
//  Copyright © 2016年 中联苹果实验室. All rights reserved.
//

#define kRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]//RGB颜色转换
#define kRGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]//ARGB颜色转换
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kSystemVersion ([[[UIDevice currentDevice] systemVersion] floatValue])//iOS版本

#define IS_IPHONE_4_OR_LESS ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height<568.0))
#define IS_IPHONE_5 ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height-568.0)?NO:YES)
#define IS_IPHONE_6 ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height-667.0)?NO:YES)
#define IS_IPHONE_6P ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height-736.0)?NO:YES)
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])//当前语言

//>=IOS7设备ID :b6bbf65ae4b470d102380cf80cbb820e28e7ee7f 注：获取UUID+bundleIdentifier（从keyChain中取，如果不存在，创建新的）
#define kCurrentDeviceId [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] uuidDeviceIdentifier]]
#define kCurrentDeviceModel [NSString stringWithFormat:@"%@",[UIDevice currentDevice].model]//设备型号 :ipad iphone ipod ，加上了4.1、4.2等后缀
#define kCurrentDeviceOS [NSString stringWithFormat:@"%@",[UIDevice currentDevice].systemName]//系统名称 :iPhone OS
#define kCurrentDeviceOSVersion [NSString stringWithFormat:@"%@",[UIDevice currentDevice].systemVersion]//设备系统版本号 :5.0.1
#define kCurrentAppName  [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]]//AppName :DoctorStation
#define kAppDisplayName NSLocalizedString(@"CFBundleDisplayName",@"")//运动酷
#define kCurrentAppVersion [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]//AppVersion :Build

#define kAppStoreAddress @"https://itunes.apple.com/cn/app/jing-ya-si-ting/id435064528?mt=8"//appStore地址

#define SELFTHENRETURN  if (userInfo.id == [UserInfo currentUser].id) return

#define appDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

//System version utils
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define degreesToRadian(x)(M_PI*(x)/180.0)

//角度转弧度
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

//大于等于7.0的ios版本
#define iOS7_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")

//大于等于8.0的ios版本
#define iOS8_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")

//获取系统时间戳
#define getCurentTime [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]
