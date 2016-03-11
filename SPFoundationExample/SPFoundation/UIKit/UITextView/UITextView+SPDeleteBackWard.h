//
//  UITextView+SPDeleteBackWard.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <UIKit/UIKit.h>

//监听删除按钮
extern NSString * const SPTextViewDidDeleteBackwardNotification;

@protocol SPTextViewDelegate<UITextViewDelegate>

@optional
- (void)textViewDidDeleteBackward:(UITextView *)textView;

@end

@interface UITextView (SPDeleteBackWard)

@property (weak, nonatomic) id<SPTextViewDelegate> delegate;

@end
