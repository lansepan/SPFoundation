//
//  UITableViewCell+SPNIB.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/8.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "UITableViewCell+SPNIB.h"

@implementation UITableViewCell (SPNIB)

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

@end
