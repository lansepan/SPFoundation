//
//  NSDateFormatter+SPMake.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (SPMake)

+(NSDateFormatter *)dateFormatterWithFormat:(NSString *)format;
+(NSDateFormatter *)dateFormatterWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone;
+(NSDateFormatter *)dateFormatterWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale;
+(NSDateFormatter *)dateFormatterWithDateStyle:(NSDateFormatterStyle)style;
+(NSDateFormatter *)dateFormatterWithDateStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone;
+(NSDateFormatter *)dateFormatterWithTimeStyle:(NSDateFormatterStyle)style;
+(NSDateFormatter *)dateFormatterWithTimeStyle:(NSDateFormatterStyle)style timeZone:(NSTimeZone *)timeZone;

@end
