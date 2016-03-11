//
//  UIDevice+SPIdentifierAddition.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/7.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "UIDevice+SPIdentifierAddition.h"
#import "SPKeyChainManager.h"
#import <CommonCrypto/CommonDigest.h>

@implementation UIDevice (SPIdentifierAddition)

- (NSString *)keyChainData
{
    NSString *identifier = [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]];
    return [NSString stringWithFormat:@"%@.data",identifier];
}

- (NSString *)keyChainUUID
{
    NSString *identifier = [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]];
    return [NSString stringWithFormat:@"%@.uuid",identifier];
}

- (NSString *)hashStringByMd5:(NSString *)orgin
{
    const char *str = [orgin UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *name = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                      r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    return name;
}

- (NSString *)uuidDeviceIdentifier
{
    NSString *uuid = @"";
    
    //从keyChain中取出UUID
    NSMutableDictionary *kvPairs = (NSMutableDictionary *)[SPKeyChainManager getKeyChain:[self keyChainData]];
    if(kvPairs!=nil)
    {
        uuid = [kvPairs objectForKey:[self keyChainUUID]];
        if(![uuid isEqualToString:@""]) return uuid;
    }
    
    uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    NSString *stringToHash = [NSString stringWithFormat:@"%@%@",uuid,bundleIdentifier];
    NSString *uniqueIdentifier = [self hashStringByMd5:stringToHash];
    
    //将UUID＋bundleIdentifier存入keyChain
    kvPairs = [NSMutableDictionary dictionary];
    [kvPairs setObject:uniqueIdentifier forKey:[self keyChainUUID]];
    [SPKeyChainManager saveKeyChain:[self keyChainData] data:kvPairs];
    
    return uniqueIdentifier;
}

@end
