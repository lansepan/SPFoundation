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

- (NSString *)replaceUnicodeToChinese
{
    return @"";
//    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
//    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
//    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
//    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
//    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"
//                                                withString:@"\n"];
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

/**
 *  得到文字和字体就能计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxW     最大的宽度
 *
 *  @return
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    NSLog(@"IOS7以上的系统");
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font {
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

//适合的高度 默认 systemFontOfSize:font
- (CGFloat)heightWithFont:(NSInteger)font w:(CGFloat)w {
    return [self boundingRectWithSize:CGSizeMake(w, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:font] } context:nil].size.height;
}

//适合的宽度 默认 systemFontOfSize:font
- (CGFloat)widthWithFont:(NSInteger)font h:(CGFloat)h {
    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, h) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:font] } context:nil].size.width;
}

//去空格
- (NSString *)delSpace {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}
//去空格
- (NSString *)delBlank {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//时间戳对应的NSDate
- (NSDate *)date {
    return [NSDate dateWithTimeIntervalSince1970:self.floatValue];
}

static NSDateFormatter *YYYYMMddHHmmss;
//YYYY-MM-dd HH:mm:ss对应的NSDate
- (NSDate *)date__YMdHMS {
    if (!YYYYMMddHHmmss) {
        YYYYMMddHHmmss = [[NSDateFormatter alloc] init];
        [YYYYMMddHHmmss setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    }
    return [YYYYMMddHHmmss dateFromString:self];
}

static NSDateFormatter *YYYYMMdd;
//YYYY-MM-dd 对应的NSDate
- (NSDate *)date__YMd {
    if (!YYYYMMdd) {
        YYYYMMdd = [[NSDateFormatter alloc] init];
        [YYYYMMdd setDateFormat:@"YYYY-MM-dd"];
    }
    return [YYYYMMdd dateFromString:self];
}
static NSDateFormatter *YYYYMMddDot;
- (NSDate *)date__YMd_Dot {
    if (!YYYYMMddDot) {
        YYYYMMddDot = [[NSDateFormatter alloc] init];
        [YYYYMMddDot setDateFormat:@"YYYY.MM.dd"];
    }
    return [YYYYMMddDot dateFromString:self];
}

//转为 Data
- (NSData *)data {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}
//转为 base64string后的Data
- (NSData *)base64Data {
    return [[NSData alloc] initWithBase64EncodedString:self options:0];
}
// 转为 base64String
- (NSString *)base64Str {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}
//解 base64为Str 解不了就返回原始的数值
- (NSString *)decodeBase64 {
    NSString *WillDecode = [[NSString alloc] initWithData:[[NSData alloc] initWithBase64EncodedString:self options:0] encoding:NSUTF8StringEncoding];
    return (WillDecode.length != 0) ? WillDecode : self;
}
// 解 为字典 if 有
- (NSDictionary *)jsonDic {
    return [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
}
// 解 为数组 if 有
- (NSArray *)jsonArr {
    return [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
}
//按字符串的，逗号分割为数组
- (NSArray *)combinArr {
    if ([self hasSuffix:@","]) {
        return [[self substringToIndex:self.length - 1] componentsSeparatedByString:@","];
    }
    return [self componentsSeparatedByString:@","];
}

#pragma mark -

//是否包含对应字符
- (BOOL)containStr:(NSString *)subString {
    return ([self rangeOfString:subString].location == NSNotFound) ? NO : YES;
}
//拼上字符串
- (NSString *)addStr:(NSString *)string {
    if (!string || string.length == 0) {
        return self;
    }
    return [self stringByAppendingString:string];
}
- (NSString *)addInt:(int)string {
    return [self stringByAppendingString:@(string).stringValue];
}

//SHA1加密
- (NSString *)SHA1 {
    const char *cStr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cStr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG) data.length, digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return [result copy];
}

- (UIImage *)qrCode {
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //    NSLog(@"filterAttributes:%@", filter.attributes);
    
    [filter setDefaults];
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    CIImage *outputImage = [filter outputImage];
    
    CIContext *context1 = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context1 createCGImage:outputImage
                                        fromRect:[outputImage extent]];
    
    UIImage *image = [UIImage imageWithCGImage:cgImage
                                         scale:1
                                   orientation:UIImageOrientationUp];
    
    //    CGFloat width = image.size.width * resize;
    //    CGFloat height = image.size.height * resize;
    //
    //    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    //    CGContextRef context2 = UIGraphicsGetCurrentContext();
    //    CGContextSetInterpolationQuality(context2, kCGInterpolationNone);
    //    [image drawInRect:CGRectMake(0, 0, width, height)];
    //    image = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    return image;
}

#pragma mark -

//是否中文
- (BOOL)isChinese {
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}
//计算字符串长度 1中文2字符
- (int)textLength {
    float number = 0.0;
    for (int index = 0; index < [self length]; index++) {
        NSString *character = [self substringWithRange:NSMakeRange(index, 1)];
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3) {
            number = number + 2;
        } else {
            number = number + 1;
        }
    }
    return ceil(number);
}
//限制最大显示长度
- (NSString *)limitMaxTextShow:(NSInteger)limit
{
    NSString *Orgin = [self copy];
    for (NSInteger i = Orgin.length; i > 0; i--) {
        NSString *Get = [Orgin substringToIndex:i];
        if (Get.textLength <= limit) {
            return Get;
        }
    }
    return self;
}

//邮箱格式验证
- (BOOL)validateEmail {
    NSString *emailRegex = @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

//手机号格式验证
- (BOOL)checkPhoneNumInput {
    NSString *Phoneend = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([Phoneend hasPrefix:@"1"] && Phoneend.textLength == 11) {
        return YES;
    }
    return NO;
    //    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    //    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    //    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    //    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    //    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    //
    //    NSString *phoneRegex = @"^((13[0-9])|(15[0-9])|(18[0,0-9]))\\d{8}$";
    //    NSString *Phoneend = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    //
    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    //    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    //    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    //    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    //    NSPredicate *regextestphoneRegex  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    //    BOOL res1 = [regextestmobile evaluateWithObject:Phoneend];
    //    BOOL res2 = [regextestcm evaluateWithObject:Phoneend];
    //    BOOL res3 = [regextestcu evaluateWithObject:Phoneend];
    //    BOOL res4 = [regextestct evaluateWithObject:Phoneend];
    //
    //    BOOL res5 = [regextestphoneRegex evaluateWithObject:Phoneend];
    //
    //    if (res1 || res2 || res3 || res4 || res5 )
    //    {
    //        return YES;
    //    }
    //    else
    //    {
    //        return NO;
    //    }
}

//验证是否ASCII码
- (BOOL)isASCII {
    NSCharacterSet *cs;
    cs = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@／:;（）¥「」!,.?<>£＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\"/"
          ""];
    NSRange specialrang = [self rangeOfCharacterFromSet:cs];
    if (specialrang.location != NSNotFound) {
        return YES;
    }
    return NO;
}

//验证是含本方法定义的 “特殊字符”
- (BOOL)isSpecialCharacter {
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／:;（）¥「」!,.?<>£＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\"/"
                           ""];
    NSRange specialrang = [self rangeOfCharacterFromSet:set];
    if (specialrang.location != NSNotFound) {
        return YES;
    }
    return NO;
}

// 验证是否是数字
- (BOOL)isNumber {
    NSCharacterSet *cs;
    cs = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSRange specialrang = [self rangeOfCharacterFromSet:cs];
    if (specialrang.location != NSNotFound) {
        return YES;
    }
    return NO;
}

// 验证字符串里面是否都是数字
- (BOOL)isPureNumber {
    NSUInteger length = [self length];
    for (float i = 0; i < length; i++) {
        // NSString * c=[mytimestr characterAtIndex:i];
        NSString *STR = [self substringWithRange:NSMakeRange(i, 1)];
        NSLog(@"%@", STR);
        if ([STR isNumber]) {
            continue;
        } else {
            return NO;
        }
    }
    return YES;
}

//是否是纯数字 这里可以有小数点
- (BOOL)isFloat {
    NSUInteger length = [self length];
    for (float i = 0; i < length; i++) {
        // NSString * c=[mytimestr characterAtIndex:i];
        NSString *STR = [self substringWithRange:NSMakeRange(i, 1)];
        NSLog(@"%@", STR);
        if ([STR isNumber] || [STR isEqualToString:@"."]) {
            continue;
        } else {
            return NO;
        }
    }
    return YES;
}

//去掉 表情符号
- (NSString *)disableEmoji {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self
                                                               options:0
                                                                 range:NSMakeRange(0, [self length])
                                                          withTemplate:@""];
    return modifiedString;
}

+ (NSString *)UUID {
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuid = CFUUIDCreateString(NULL, uuidRef);
    
    CFRelease(uuidRef);
    
    return (__bridge_transfer NSString *) uuid;
}

@end

@implementation NSDictionary (WT)

//字典 转为 JsonStr
- (NSString *)jsonStr {
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:0 error:NULL] encoding:NSUTF8StringEncoding];
}


@end
