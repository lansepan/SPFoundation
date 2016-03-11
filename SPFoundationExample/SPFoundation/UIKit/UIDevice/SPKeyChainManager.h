//
//  SPKeyChainManager.h
//  SPFoundationExample
//
//  Created by BluePan on 16/3/7.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface SPKeyChainManager : NSObject

+ (void)saveKeyChain:(NSString *)service data:(id)data;
+ (id)getKeyChain:(NSString *)service;
+ (void)deleteKeyChain:(NSString *)service;

@end
