//
//  UITextView+AttributedString.h
//  SPFoundationExample
//
//  Created by BluePan on 16/9/10.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (AttributedString)

/** 插入NSAttributedString */
- (void)insertAttributedText:(NSAttributedString *)text;

- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *attributedText))settingBlock;

@end
