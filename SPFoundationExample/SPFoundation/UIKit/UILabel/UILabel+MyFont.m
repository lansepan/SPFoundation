//
//  UILabel+MyFont.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/21.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "UILabel+MyFont.h"

@implementation UILabel (MyFont)

+ (void)load
{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode
{
    [self myInitWithCoder:aDecode];
    if (self)
    {
        //部分不像改变字体的 把tag值设置成333跳过
        if(self.tag != 333)
        {
            CGFloat h = [UIScreen mainScreen].bounds.size.height;
            CGFloat scale = ((h > 568) ? h/568 : 1);
            
            CGFloat fontSize = self.font.pointSize;
            self.font = [UIFont systemFontOfSize:fontSize*scale];
        }
    }
    return self;
}

@end
