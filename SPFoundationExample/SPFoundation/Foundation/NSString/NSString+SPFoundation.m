//
//  NSString+SPFoundation.m
//  SPFoundationExample
//
//  Created by BluePan on 16/3/7.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

#import "NSString+SPFoundation.h"

@implementation NSString (SPFoundation)

- (NSString *)stringFromMD5
{
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++)
    {
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    return outputString;
}

//文件或文件夹大小
- (NSInteger)fileSize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    if (exists == NO) return 0;
    if (isDirectory)
    {
        NSInteger size = 0;
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        for (NSString *subpath in enumerator)
        {
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
        }
        return size;
    }
    else
    {
        return [mgr attributesOfItemAtPath:self error:nil].fileSize;
    }
}

@end
