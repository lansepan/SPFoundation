//
//  NSString+Utils.h
//  Blast
//
//  Created by leon on 3/29/16.
//  Copyright © 2016 codoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

- (NSString *)trim;

- (NSString *)MD5;

- (NSString *)replaceUnicodeToChinese;

//识别文本中的链接
- (NSArray *)textLinks;

//去空行
- (NSString *)filterBlankAndBlankLines;

/// 识别文本中指定类型的对象
- (NSArray<NSTextCheckingResult *> *)detectWithCheckingTypes:(NSTextCheckingTypes)checkingTypes;

@end
