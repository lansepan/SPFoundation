//
//  NSString+SPFoundation.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/7.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (SPFoundation)

- (NSString *)stringFromMD5;

//阿拉伯数字转换为中文数字
+ (NSString *)translationArabicNum:(NSInteger)arabicNum;

@end
