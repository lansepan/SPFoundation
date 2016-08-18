//
//  NSLayoutConstraintHairline.m
//  JingYaSiTing
//
//  Created by BluePan on 16/6/21.
//  Copyright © 2016年 中联苹果实验室. All rights reserved.
//

#import "NSLayoutConstraintHairline.h"

@implementation NSLayoutConstraintHairline

- (void) awakeFromNib
{
    [super awakeFromNib];
    if(self.constant==1) self.constant = 1.0/[UIScreen mainScreen].scale;
}

@end
