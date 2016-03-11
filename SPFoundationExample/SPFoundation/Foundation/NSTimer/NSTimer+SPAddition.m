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

@end
