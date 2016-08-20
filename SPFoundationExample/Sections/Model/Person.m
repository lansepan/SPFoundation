//
//  Person.m
//  SPFoundationExample
//
//  Created by BluePan on 16/8/20.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import "SPSerializeKit.h"

//是否使用通用的encode/decode代码一次性encode/decode
#define USING_ENCODE_KIT            1

@implementation Person

WZLSERIALIZE_CODER_DECODER();

WZLSERIALIZE_COPY_WITH_ZONE();

WZLSERIALIZE_DESCRIPTION();

@end
