//
//  UILabel+SPFoundation.m
//  SPFoundationExample
//
//  Created by BluePan on 16/6/4.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "UILabel+SPFoundation.h"

@implementation UILabel (SPFoundation)

//添加中划线
- (void)addStrikethrough
{
    NSString *textStr = self.text;
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
    self.attributedText = attribtStr;
}

//添加下划线
- (void)addUnderline
{
    NSString *textStr = self.text;
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
    self.attributedText = attribtStr;
}

@end
