//
//  SPPlaceholderColorTextField.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/7.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "SPPlaceholderColorTextField.h"
#import <objc/runtime.h>

#define SPPlaceholderColorKey @"placeholderLabel.textColor"

@implementation SPPlaceholderColorTextField

- (void)awakeFromNib
{
    if(!self.cursorColor) self.cursorColor = [UIColor whiteColor];
    if(!self.placeholderColor) self.cursorColor = [UIColor grayColor];
    if(!self.placeholderFocusColor) self.placeholderFocusColor = [UIColor whiteColor];
    
    self.tintColor = self.cursorColor;
    self.textColor = self.textColor;
    [self setValue:self.placeholderColor forKeyPath:SPPlaceholderColorKey];
    [self resignFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    [self setValue:self.placeholderFocusColor forKeyPath:SPPlaceholderColorKey];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    [self setValue:self.placeholderColor forKeyPath:SPPlaceholderColorKey];
    return [super resignFirstResponder];
}

@end
