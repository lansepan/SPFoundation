//
//  NSString+SPBase64.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SPBase64)

+ (NSString *)stringWithBase64EncodedString:(NSString *)string;
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
//返回base64编码的字符串内容
- (NSString *)base64EncodedString;
//返回base64解码的字符串内容
- (NSString *)base64DecodedString;
- (NSData *)base64DecodedData;

@end
