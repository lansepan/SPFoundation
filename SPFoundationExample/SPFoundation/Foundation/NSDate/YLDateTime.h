//
//  YLDateTime.h
//  CMStepCounterDemo
//
//  Created by Hatta Yasuhiro on 2014/03/08.
//  Copyright (c) 2014年 yaslab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLDateTime : NSObject

//Init
+ (YLDateTime *)now;
+ (YLDateTime *)today;
//获取时间间隔，分钟
+ (int)timeIntervalSinceDate:(NSDate *)begDate endDate:(NSDate *)endDate;
- (id)init;
- (id)initWithDate:(NSDate *)nsdate;
- (id)initWithDateComponents:(NSDateComponents *)comps;
- (id)initWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
- (id)initWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

//Calendar
@property (nonatomic, readonly) NSDate *nsdate;
@property (nonatomic, strong) NSCalendar *calendar;

//Components
@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger hour;
@property (nonatomic, readonly) NSInteger minute;
@property (nonatomic, readonly) NSInteger second;
@property (nonatomic, readonly) NSInteger weekday;
@property (nonatomic, readonly) NSInteger weekdayOrdinal;
@property (nonatomic, readonly) NSInteger weekOfMonth;
@property (nonatomic, readonly) NSInteger weekOfYear;

//Adding
- (YLDateTime *)dateByAddingYear:(NSInteger)year;
- (YLDateTime *)dateByAddingMonth:(NSInteger)month;
- (YLDateTime *)dateByAddingDay:(NSInteger)day;
- (YLDateTime *)dateByAddingHour:(NSInteger)hour;
- (YLDateTime *)dateByAddingMinute:(NSInteger)minute;
- (YLDateTime *)dateByAddingSecond:(NSInteger)second;
- (YLDateTime *)dateByAddingWeek:(NSInteger)week;
- (YLDateTime *)dateByAddingWeekday:(NSInteger)weekday;
- (YLDateTime *)dateByAddingWeekdayOrdinal:(NSInteger)weekdayOrdinal;
- (YLDateTime *)dateByAddingWeekOfMonth:(NSInteger)weekOfMonth;
- (YLDateTime *)dateByAddingWeekOfYear:(NSInteger)weekOfYear;

@end
