//
//  UITextView+SPPlaceHolder.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "UITextView+SPPlaceHolder.h"
#import <objc/runtime.h>

static const char *phTextView = "placeHolderTextView";

@implementation UITextView (SPPlaceHolder)

- (UITextView *)placeHolderTextView
{
    return objc_getAssociatedObject(self, phTextView);
}

- (void)setPlaceHolderTextView:(UITextView *)placeHolderTextView
{
    objc_setAssociatedObject(self, phTextView, placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addPlaceHolder:(NSString *)placeHolder
{
    if (![self placeHolderTextView])
    {
        self.delegate = self;
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor grayColor];
        textView.userInteractionEnabled = NO;
        textView.text = placeHolder;
        [self addSubview:textView];
        [self setPlaceHolderTextView:textView];
    }
}

#pragma mark - UITextViewDelegate Methods

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.placeHolderTextView.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text && [textView.text isEqualToString:@""])
    {
        self.placeHolderTextView.hidden = NO;
    }
}

@end
