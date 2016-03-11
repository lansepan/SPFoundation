//
//  NSString+SPPinyin.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <Foundation/Foundation.h>

//@"中文"
@interface NSString (SPPinyin)

- (NSString *)pinyinWithPhoneticSymbol;//@"zhōng wén"
- (NSString *)pinyin;//@"zhong wen"
- (NSArray *)pinyinArray;//@[@"zhong", @"wen"]
- (NSString *)pinyinWithoutBlank;//@"zhongwen"
- (NSArray *)pinyinInitialsArray;//@[@"z", @"w"]
- (NSString *)pinyinInitialsString;//@"zw"

@end
