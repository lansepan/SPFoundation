//
//  UILabel+SPFoundation.m
//  SPFoundationExample
//
//  Created by BluePan on 16/6/4.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "UILabel+SPFoundation.h"

#define SPStrIsEmpty(str) ([str isKindOfClass:[NSNull class]] || [str length] < 1 ? YES : NO || [str isEqualToString:@"(null)"] || [str isEqualToString:@"null"])

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

+ (UILabel *)newSingleFrame:(CGRect)frame title:(NSString *)title fontS:(CGFloat)fonts color:(UIColor *)color {
    UILabel *_ = [[UILabel alloc] initWithFrame:frame];
    _.font = [UIFont systemFontOfSize:fonts];
    if (color) {
        _.textColor = color;
    }
    _.text = title;
    _.numberOfLines = 0;
    return _;
}

/** 有删除线的 */
- (void)delLineStr:(NSString *)string {
    if (SPStrIsEmpty(string)) return;
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:string];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, string.length)];
    [self setAttributedText:attri];
}

/** 有下划线的 */
- (void)underlineStr:(NSString *)string {
    if (SPStrIsEmpty(string)) return;
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:string];
    [attri addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, string.length)];
    [self setAttributedText:attri];
}

- (void)settingLabelHeightofRowString:(NSString*)string{
    [self settingLabelRowOfHeight:10 string:string];
}

- (void)settingLabelRowOfHeight:(CGFloat)height string:(NSString*)string{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:height]; //调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}


- (void)htmlString:(NSString *)htmlStr{
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.attributedText = attributedString;
}

- (void)htmlString:(NSString *)htmlStr labelRowOfHeight:(CGFloat)height{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:height]; //调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributedString length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}


@end
