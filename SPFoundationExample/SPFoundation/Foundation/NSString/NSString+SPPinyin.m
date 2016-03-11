//
//  NSString+SPPinyin.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "NSString+SPPinyin.h"

@implementation NSString (SPPinyin)

- (NSString*)pinyinWithPhoneticSymbol
{
    NSMutableString *pinyin = [NSMutableString stringWithString:self];
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformMandarinLatin, NO);
    return pinyin;
}

- (NSString*)pinyin
{
    NSMutableString *pinyin = [NSMutableString stringWithString:[self pinyinWithPhoneticSymbol]];
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformStripCombiningMarks, NO);
    return pinyin;
}

- (NSArray*)pinyinArray
{
    NSArray *array = [[self pinyin] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return array;
}

- (NSString*)pinyinWithoutBlank
{
    NSMutableString *string = [NSMutableString stringWithString:@""];
    for (NSString *str in [self pinyinArray])
    {
        [string appendString:str];
    }
    return string;
}

- (NSArray*)pinyinInitialsArray
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *str in [self pinyinArray])
    {
        if ([str length] > 0)
        {
            [array addObject:[str substringToIndex:1]];
        }
    }
    return array;
}

- (NSString*)pinyinInitialsString
{
    NSMutableString *pinyin = [NSMutableString stringWithString:@""];
    for (NSString *str in [self pinyinArray])
    {
        if ([str length] > 0)
        {
            [pinyin appendString:[str substringToIndex:1]];
        }
    }
    return pinyin;
}

@end
