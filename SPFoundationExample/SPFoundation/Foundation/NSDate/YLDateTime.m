//
//  YLDateTime.m
//  CMStepCounterDemo
//
//  Created by Hatta Yasuhiro on 2014/03/08.
//  Copyright (c) 2014年 yaslab. All rights reserved.
//

#import "YLDateTime.h"

@implementation YLDateTime

#ifdef __IPHONE_8_0
#define GregorianCalendar NSCalendarIdentifierGregorian
#else
#define GregorianCalendar NSGregorianCalendar
#endif

- (NSCalendar *)_getDefaultCalendar
{
    return [[NSCalendar alloc] initWithCalendarIdentifier:GregorianCalendar];
}

#pragma mark - Init

+ (YLDateTime *)now
{
    return [self new];
}

+ (YLDateTime *)today
{
    YLDateTime *now = [self new];
    return [[self alloc] initWithYear:now.year month:now.month day:now.day];
}

//获取时间间隔，分钟
+ (int)timeIntervalSinceDate:(NSDate *)begDate endDate:(NSDate *)endDate
{
    NSTimeInterval seconds = [endDate timeIntervalSinceDate:begDate];
    int minute = ((int)seconds)/60;
    return minute;
}

- (id)init
{
    YLDateTime *obj = [self initWithDate:[NSDate new]];
    return obj;
}

- (id)initWithDate:(NSDate *)nsdate
{
    self = [super init];
    if (self) {
        _nsdate = nsdate;
        _calendar = [self _getDefaultCalendar];
    }
    return self;
}

- (id)initWithDateComponents:(NSDateComponents *)comps
{
    self = [super init];
    YLDateTime *obj = [self initWithDate:nil];
    _nsdate = [obj.calendar dateFromComponents:comps];
    return obj;
}

- (id)initWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSDateComponents *comps = [NSDateComponents new];
    comps.year = year;
    comps.month = month;
    comps.day = day;
    return [self initWithDateComponents:comps];
}

- (id)initWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
{
    NSDateComponents *comps = [NSDateComponents new];
    comps.year = year;
    comps.month = month;
    comps.day = day;
    comps.hour = hour;
    comps.minute = minute;
    comps.second = second;
    return [self initWithDateComponents:comps];
}

#pragma mark - Components

- (NSInteger)year
{
    return [self.calendar components:NSCalendarUnitYear fromDate:self.nsdate].year;
}

- (NSInteger)month
{
    return [self.calendar components:NSCalendarUnitMonth fromDate:self.nsdate].month;
}

- (NSInteger)day
{
    return [self.calendar components:NSCalendarUnitDay fromDate:self.nsdate].day;
}

- (NSInteger)hour
{
    return [self.calendar components:NSCalendarUnitHour fromDate:self.nsdate].hour;
}

- (NSInteger)minute
{
    return [self.calendar components:NSCalendarUnitMinute fromDate:self.nsdate].minute;
}

- (NSInteger)second
{
    return [self.calendar components:NSCalendarUnitSecond fromDate:self.nsdate].second;
}

- (NSInteger)weekday
{
    return [self.calendar components:NSCalendarUnitWeekday fromDate:self.nsdate].weekday;
}

- (NSInteger)weekdayOrdinal
{
    return [self.calendar components:NSCalendarUnitWeekdayOrdinal fromDate:self.nsdate].weekdayOrdinal;
}

- (NSInteger)weekOfMonth
{
    return [self.calendar components:NSCalendarUnitWeekOfMonth fromDate:self.nsdate].weekOfMonth;
}

- (NSInteger)weekOfYear
{
    return [self.calendar components:NSCalendarUnitWeekOfYear fromDate:self.nsdate].weekOfYear;
}

#pragma mark - Adding

- (YLDateTime *)_addComps:(NSDateComponents *)comps
{
    NSDate *nsdate = [self.calendar dateByAddingComponents:comps toDate:self.nsdate options:0];
    YLDateTime *obj = [[YLDateTime alloc] initWithDate:nsdate];
    obj.calendar = self.calendar;
    return obj;
}

- (YLDateTime *)dateByAddingYear:(NSInteger)year
{
    NSDateComponents *comps = [NSDateComponents new];
    comps.year = year;
    return [self _addComps:comps];
}

- (YLDateTime *)dateByAddingMonth:(NSInteger)month
{
    NSDateComponents *comps = [NSDateComponents new];
    comps.month = month;
    return [self _addComps:comps];
}

- (YLDateTime *)dateByAddingDay:(NSInteger)day
{
    NSDateComponents *comps = [NSDateComponents new];
    comps.day = day;
    return [self _addComps:comps];
}

- (YLDateTime *)dateByAddingHour:(NSInteger)hour
{
    NSDateComponents *comps = [NSDateComponents new];
    comps.hour = hour;
    return [self _addComps:comps];
}

- (YLDateTime *)dateByAddingMinute:(NSInteger)minute
{
    NSDateComponents *comps = [NSDateComponents new];
    comps.minute = minute;
    return [self _addComps:comps];
}

- (YLDateTime *)dateByAddingSecond:(NSInteger)second
{
    NSDateComponents *comps = [NSDateComponents new];
    comps.second = second;
    return [self _addComps:comps];
}

- (YLDateTime *)dateByAddingWeek:(NSInteger)week
{
    NSDateComponents *comps = [NSDateComponents new];
    comps.weekOfMonth = week;
    return [self _addComps:comps];
}

- (YLDateTime *)dateByAddingWeekday:(NSInteger)weekday
{
    NSDateComponents *comps = [NSDateComponents new];
    comps.weekday = weekday;
    return [self _addComps:comps];
}

- (YLDateTime *)dateByAddingWeekdayOrdinal:(NSInteger)weekdayOrdinal
{
    NSDateComponents *comps = [NSDateComponents new];
    comps.weekdayOrdinal = weekdayOrdinal;
    return [self _addComps:comps];
}

- (YLDateTime *)dateByAddingWeekOfMonth:(NSInteger)weekOfMonth
{
    NSDateComponents *comps = [NSDateComponents new];
    comps.weekOfMonth = weekOfMonth;
    return [self _addComps:comps];
}

- (YLDateTime *)dateByAddingWeekOfYear:(NSInteger)weekOfYear
{
    NSDateComponents *comps = [NSDateComponents new];
    comps.weekOfYear = weekOfYear;
    return [self _addComps:comps];
}

@end
