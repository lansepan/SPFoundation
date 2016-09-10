//
//  NSString+Emoji.h
//  SPFoundationExample
//
//  Created by BluePan on 16/9/10.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Emoji)

// 😀😉😌😰😂 Emoji start
/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)emojiWithIntCode:(int)intCode;

/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)emojiWithStringCode:(NSString *)stringCode;
- (NSString *)emoji;

/**
 *  是否为emoji字符
 */
- (BOOL)isEmoji;
/** 去掉 表情符号 可能漏了一些 */
- (NSString *)disableEmoji;
// 😀😉😌😰😂 Emoji end

@end
