//
//  SPLocationManager.h
//  SportsCool
//
//  Created by BluePan on 14-1-19.
//  Copyright (c) 2014年 Chengdu SportsCool Network Technology Inc. All rights reserved.
//

//位置信息管理
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

//根据经纬度获取详细地址信息
typedef void (^ReverseGeocodeLocationBlock)(NSString *country,NSString *province,NSString *city,NSString *name,NSString *shortName,NSError *error);

//根据地址获取经纬度
typedef void (^GeocodeAddressStringBlock)(CLPlacemark *placemark,CLLocation *location,NSString *address,NSError *error);

//获取当前位置
typedef void (^LocationBlock)(CLLocation *location,NSString *country,NSString *province,NSString *city,NSString *name,NSString *shortName,NSError *error);

//获取提示关键字
typedef void (^SearchTipsBlock)(NSArray *arrrayTips,NSMutableArray *arrayLocations, NSString *errorInfo);

//错误信息
typedef void (^LocationErrorBlock)(NSError *error);

@interface SPLocationManager : NSObject<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

+ (SPLocationManager *)shareLocation;

//获取地址详细信息
- (void)reverseGeocodeLocation:(CLLocation *)loc rgcBlock:(ReverseGeocodeLocationBlock)rgcBlock;
//根据地址获取经纬度
- (void)geocodeAddressString:(NSString *)address gecBlock:(GeocodeAddressStringBlock)gecBlock;
//获取当前位置信息
- (void)getLocationCoordinate:(LocationBlock)locaiontBlock;

@end
