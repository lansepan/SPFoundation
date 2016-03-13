//
//  SPLocationManager.m
//  SportsCool
//
//  Created by BluePan on 14-1-19.
//  Copyright (c) 2014年 Chengdu SportsCool Network Technology Inc. All rights reserved.
//

#import "SPLocationManager.h"

@interface SPLocationManager(/*Private*/)

@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) NSString *country,*province,*city,*name,*shortName;
//@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) ReverseGeocodeLocationBlock reverseGeocodeLocationBlock;
@property (nonatomic, strong) GeocodeAddressStringBlock geocodeAddressStringBlock;
@property (nonatomic, strong) LocationBlock locationBlock;
@property (nonatomic, strong) SearchTipsBlock tipsBlock;
@property (nonatomic, strong) LocationErrorBlock errorBlock;

@end

@implementation SPLocationManager

+ (SPLocationManager *)shareLocation;
{
    static SPLocationManager *shareObj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareObj = [[self alloc] init];
    });
    return shareObj;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    return self;
}

- (void)dealloc
{
//    self.mapView.showsUserLocation = NO;
//    self.mapView.delegate = nil;
//    self.mapView = nil;
    self.locationManager.delegate = nil;
}

- (void)startLocation
{
    [self.locationManager requestAlwaysAuthorization];//定位授权
    [self.locationManager requestWhenInUseAuthorization];//定位授权
    if([CLLocationManager locationServicesEnabled]) //本地定位功能是否开启
    {
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;//设置精度
        self.locationManager.distanceFilter = 1;
        [self.locationManager startUpdatingLocation];//开始更新当前坐标位置
    }
    else
    {
        UIAlertController *action = [UIAlertController alertControllerWithTitle:@"" message:@"请打开定位服务，才能获取最新信息。" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        [action addAction:cancelAction];
    }
}

- (void)stopLocation
{
//    self.mapView.showsUserLocation = NO;
//    self.mapView.delegate = nil;
//    self.mapView = nil;
    [self.locationManager stopUpdatingLocation];
}

//获取地址详细信息
- (void)reverseGeocodeLocation:(CLLocation *)loc rgcBlock:(ReverseGeocodeLocationBlock)rgcBlock
{
    self.reverseGeocodeLocationBlock = [rgcBlock copy];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        //               name:市民广场
        //               country:中国
        //               postalCode:(null)
        //               ISOcountryCode:CN
        //               ocean:(null)
        //               inlandWater:(null)
        //               locality:广东省
        //               subLocality:(null)
        //               administrativeArea:深圳市
        //               subAdministrativeArea:福田区
        //               thoroughfare:市民广场
        //               subThoroughfare:(null)
        self.country = placemark.country?placemark.country:@"";
        self.province = placemark.administrativeArea?placemark.administrativeArea:@"";
        self.city = placemark.locality?placemark.locality:self.province;
        NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
        NSString *strPrefix = [NSString stringWithFormat:@"%@%@",placemark.country,[placemark.administrativeArea isEqualToString:self.city]?@"":placemark.administrativeArea];
        if([locatedAt hasPrefix:strPrefix]) locatedAt = [locatedAt substringFromIndex:strPrefix.length];
        self.name = locatedAt;
        
        NSString *address = placemark.locality?placemark.locality:@"";
        if(placemark.subLocality) address = [NSString stringWithFormat:@"%@ %@",address,placemark.subLocality];
        if(placemark.thoroughfare) address = [NSString stringWithFormat:@"%@ %@",address,placemark.thoroughfare];
        self.shortName = address;
        
        if(self.reverseGeocodeLocationBlock)
        {
            self.reverseGeocodeLocationBlock(self.country,self.province,self.city,self.name,self.shortName,error);
            self.reverseGeocodeLocationBlock = nil;
        }
    }];
}

//根据地址获取经纬度
- (void)geocodeAddressString:(NSString *)address gecBlock:(GeocodeAddressStringBlock)gecBlock
{
    self.geocodeAddressStringBlock = [gecBlock copy];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        if(self.geocodeAddressStringBlock)
        {
            self.geocodeAddressStringBlock(placemark,placemark.location,address,error);
            self.geocodeAddressStringBlock = nil;
        }
    }];
}

//获取当前位置信息
- (void)getLocationCoordinate:(LocationBlock)locaiontBlock
{
    self.locationBlock = [locaiontBlock copy];
    [self startLocation];
}

#pragma mark - CLLocationManagerDelegate Methods

+ (CLLocation *)transformToMars:(CLLocation *)location
{
    //是否在中国大陆之外
    if ([[self class] outOfChina:location]) return location;
    
    const double a = 6378245.0;
    const double ee = 0.00669342162296594323;
    
    double dLat = [[self class] transformLatWithX:location.coordinate.longitude - 105.0 y:location.coordinate.latitude - 35.0];
    double dLon = [[self class] transformLonWithX:location.coordinate.longitude - 105.0 y:location.coordinate.latitude - 35.0];
    double radLat = location.coordinate.latitude / 180.0 * M_PI;
    double magic = sin(radLat);
    magic = 1 - ee * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * M_PI);
    dLon = (dLon * 180.0) / (a / sqrtMagic * cos(radLat) * M_PI);
    return [[CLLocation alloc] initWithLatitude:location.coordinate.latitude + dLat longitude:location.coordinate.longitude + dLon];
}

+ (BOOL)outOfChina:(CLLocation *)location
{
    if (location.coordinate.longitude < 72.004 || location.coordinate.longitude > 137.8347) {
        return YES;
    }
    if (location.coordinate.latitude < 0.8293 || location.coordinate.latitude > 55.8271) {
        return YES;
    }
    return NO;
}

+ (double)transformLatWithX:(double)x y:(double)y
{
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * M_PI) + 40.0 * sin(y / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * M_PI) + 320 * sin(y * M_PI / 30.0)) * 2.0 / 3.0;
    return ret;
}

+ (double)transformLonWithX:(double)x y:(double)y
{
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * M_PI) + 40.0 * sin(x / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * M_PI) + 300.0 * sin(x / 30.0 * M_PI)) * 2.0 / 3.0;
    return ret;
}

//位置更新
/*
 CLLocation类代表一个位置信息，其中还包括了方向和速度。比如我在长安街188号以5公里/小时的速度往西走。CLLocation具有下面的属性和方法：
 @property  CLLocationCoordinate2D coordinate; //以经度和纬度表示的位置信息
 @property CLLocationDistance altitude;  //海拔
 @property CLLocationAccuracy horizontalAccuracy; //水平精度（如：精确到米）
 @property CLLocationAccuracy verticalAccuracy; //垂直精度
 @property CLLocationDirection course; //方向
 @property CLLocationSpeed speed; //速度
 -（NSDate *）timeStamp;
 //两个位置之间的距离
 -(CLLocationDistance)distanceFromLocation:(CLLocation *)location;
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *curLocation = [SPLocationManager transformToMars:newLocation];
    if(curLocation!=nil)
    {
        [self reverseGeocodeLocation:curLocation rgcBlock:^(NSString *country, NSString *province, NSString *city, NSString *name, NSString *shortName, NSError *error) {
            
            self.location = curLocation;
            self.country = country;
            self.province = province;
            self.city = city;
            self.name = name;
            self.shortName = shortName;
            
            [self stopLocation];
            if(self.locationBlock)
            {
                self.locationBlock(self.location,self.country,self.province,self.city,self.name,self.shortName,error);
                self.locationBlock = nil;
            }
        }];
    }
}

//当用户改变方向的时候，所调用的方法是
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
}

//获取位置失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
}

#pragma mark - MKMapViewDelegate Methods

//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
//{
//    [self reverseGeocodeLocation:userLocation.location rgcBlock:^(NSString *country, NSString *province, NSString *city, NSString *name, NSString *shortName, NSError *error) {
//        
//        self.location = userLocation.location;
//        self.country = country;
//        self.province = province;
//        self.city = city;
//        self.name = name;
//        self.shortName = shortName;
//    
//        [self stopLocation];
//        if(self.locationBlock)
//        {
//            self.locationBlock(self.location,self.country,self.province,self.city,self.name,self.shortName,error);
//            self.locationBlock = nil;
//        }
//    }];
//}
//
//- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
//{
//    [self stopLocation];
//}

@end
