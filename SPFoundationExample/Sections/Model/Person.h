//
//  Person.h
//  SPFoundationExample
//
//  Created by BluePan on 16/8/20.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Biology.h"

@interface Person : Biology<NSCopying, NSCoding>
{
    NSString *_father;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

@end
