//
//  NSTimer+SPAddition.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "NSTimer+SPAddition.h"

@implementation NSTimer (SPAddition)

/**
 *  @brief  暂停NSTimer
 */
- (void)pauseTimer
{
    if (![self isValid])
    {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}

/**
 *  @brief  开始NSTimer
 */
- (void)resumeTimer
{
    if (![self isValid])
    {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

/**
 *  @brief  延迟开始NSTimer
 */
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid])
    {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

//而scheduled的初始化方法将以默认mode直接添加到当前的runloop中.
+ (id)runTimer:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock rep:(BOOL)inRepeats {
    void (^block)() = [inBlock copy];
    id ret = [self scheduledTimerWithTimeInterval:inTimeInterval target:self selector:@selector(jdExecuteSimpleBlock:) userInfo:block repeats:inRepeats];
    return ret;
}

//不用scheduled方式初始化的，需要手动addTimer:forMode: 将timer添加到一个runloop中。   [[NSRunLoop currentRunLoop]addTimer:he forMode:NSDefaultRunLoopMode];
+ (id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats {
    void (^block)() = [inBlock copy];
    id ret = [self timerWithTimeInterval:inTimeInterval target:self selector:@selector(jdExecuteSimpleBlock:) userInfo:block repeats:inRepeats];
    return ret;
}

+ (void)jdExecuteSimpleBlock:(NSTimer *)inTimer;
{
    if ([inTimer userInfo]) {
        void (^block)() = (void (^)())[inTimer userInfo];
        block();
    }
}

/**
 *  暂停
 */
- (void)pause {
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate distantFuture]];
}

/**
 *  继续
 */
- (void)goOn {
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate date]];
}

/**
 *  X秒后继续
 */
- (void)goOn:(NSTimeInterval)interval {
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

@end
