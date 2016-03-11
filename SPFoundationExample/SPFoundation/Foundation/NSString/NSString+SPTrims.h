//
//  NSString+SPTrims.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SPTrims)

/**
 *  @brief  清除html标签
 *
 *  @return 清除后的结果
 */
- (NSString *)stringByStrippingHTML;

/**
 *  @brief  清除js脚本
 *
 *  @return 清楚js后的结果
 */
- (NSString *)stringByRemovingScriptsAndStrippingHTML;

/**
 *  @brief  去除空格
 *
 *  @return 去除空格后的字符串
 */
- (NSString *)trimmingWhitespace;

/**
 *  @brief  去除字符串与空行
 *
 *  @return 去除字符串与空行的字符串
 */
- (NSString *)trimmingWhitespaceAndNewlines;

@end
