//
//  NSString+Utils.m
//  Blast
//
//  Created by leon on 3/29/16.
//  Copyright © 2016 codoon. All rights reserved.
//

#import "NSString+Utils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Utils)

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)MD5 {
    // Create pointer to the string as UTF8
    const char* ptr = [self UTF8String];
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, (CC_LONG) strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",md5Buffer[i]];
    }
    
    return output;
}

- (NSString *)replaceUnicodeToChinese {
    
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"
                                                withString:@"\n"];
}

//识别文本中的链接
- (NSArray *)textLinks
{
    NSError *error;
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    return arrayOfAllMatches;
}

- (NSString *)filterBlankAndBlankLines
{
    NSMutableString *Mstr = [NSMutableString string];
    NSArray *arr = [self componentsSeparatedByString:@"\n"];
    for(int i =0; i < arr.count; i++) {
        NSString *tempStr = (NSString*)arr[i];
        //去除掉首尾的空白字符和换行字符
        [tempStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [tempStr stringByReplacingOccurrencesOfString:@"\r"withString:@""];
        [tempStr stringByReplacingOccurrencesOfString:@"\n"withString:@""];
        if(tempStr.length!=0) {
            [Mstr appendString:arr[i]];
            if(i < [arr count] -1) {
                [Mstr appendString:@"\n"];
            }
        }
    }
    return Mstr;
}

/// 识别文本中指定类型的对象
- (NSArray<NSTextCheckingResult *> *)detectWithCheckingTypes:(NSTextCheckingTypes)checkingTypes {
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:checkingTypes error:nil];
    return [detector matchesInString:self options:0 range:NSMakeRange(0, self.length)];
}

@end
