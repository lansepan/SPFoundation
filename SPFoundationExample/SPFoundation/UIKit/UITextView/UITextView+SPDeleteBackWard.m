//
//  UITextView+SPDeleteBackWard.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "UITextView+SPDeleteBackWard.h"
#import <objc/runtime.h>

NSString * const SPTextViewDidDeleteBackwardNotification = @"com.sportscool.textview.did.notification";

@implementation UITextView (SPDeleteBackWard)

+ (void)load
{
    //交换2个方法中的IMP
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"deleteBackward"));
    Method method2 = class_getInstanceMethod([self class], @selector(sp_deleteBackward));
    method_exchangeImplementations(method1, method2);
}

- (void)sp_deleteBackward
{
    [self sp_deleteBackward];
    
    if ([self.delegate respondsToSelector:@selector(textViewDidDeleteBackward:)])
    {
        id <SPTextViewDelegate> delegate  = (id<SPTextViewDelegate>)self.delegate;
        [delegate textViewDidDeleteBackward:self];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:SPTextViewDidDeleteBackwardNotification object:self];
}

@end
