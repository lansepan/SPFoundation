//
//  SPSerializeKit.h
//  SPFoundationExample
//
//  Created by BluePan on 16/8/20.
//  Copyright © 2016年 易云世纪科技. All rights reserved.
//

//序列化与反序列集成
#ifndef SPSerializeKit_h
#define SPSerializeKit_h

#import <objc/runtime.h>

#define WZLSERIALIZE_CODER_DECODER()     \
\
- (id)initWithCoder:(NSCoder *)coder    \
{   \
NSLog(@"%s",__func__);  \
Class cls = [self class];   \
while (cls != [NSObject class]) {   \
/*判断是自身类还是父类*/    \
BOOL bIsSelfClass = (cls == [self class]);  \
unsigned int iVarCount = 0; \
unsigned int propVarCount = 0;  \
unsigned int sharedVarCount = 0;    \
Ivar *ivarList = bIsSelfClass ? class_copyIvarList([cls class], &iVarCount) : NULL;/*变量列表，含属性以及私有变量*/   \
objc_property_t *propList = bIsSelfClass ? NULL : class_copyPropertyList(cls, &propVarCount);/*属性列表*/   \
sharedVarCount = bIsSelfClass ? iVarCount : propVarCount;   \
\
for (int i = 0; i < sharedVarCount; i++) {  \
const char *varName = bIsSelfClass ? ivar_getName(*(ivarList + i)) : property_getName(*(propList + i)); \
NSString *key = [NSString stringWithUTF8String:varName];   \
id varValue = [coder decodeObjectForKey:key];   \
NSArray *filters = @[@"superclass", @"description", @"debugDescription", @"hash"]; \
if (varValue && [filters containsObject:key] == NO) { \
[self setValue:varValue forKey:key];    \
}   \
}   \
free(ivarList); \
free(propList); \
cls = class_getSuperclass(cls); \
}   \
return self;    \
}   \
\
- (void)encodeWithCoder:(NSCoder *)coder    \
{   \
NSLog(@"%s",__func__);  \
Class cls = [self class];   \
while (cls != [NSObject class]) {   \
/*判断是自身类还是父类*/    \
BOOL bIsSelfClass = (cls == [self class]);  \
unsigned int iVarCount = 0; \
unsigned int propVarCount = 0;  \
unsigned int sharedVarCount = 0;    \
Ivar *ivarList = bIsSelfClass ? class_copyIvarList([cls class], &iVarCount) : NULL;/*变量列表，含属性以及私有变量*/   \
objc_property_t *propList = bIsSelfClass ? NULL : class_copyPropertyList(cls, &propVarCount);/*属性列表*/ \
sharedVarCount = bIsSelfClass ? iVarCount : propVarCount;   \
\
for (int i = 0; i < sharedVarCount; i++) {  \
const char *varName = bIsSelfClass ? ivar_getName(*(ivarList + i)) : property_getName(*(propList + i)); \
NSString *key = [NSString stringWithUTF8String:varName];    \
/*valueForKey只能获取本类所有变量以及所有层级父类的属性，不包含任何父类的私有变量(会崩溃)*/  \
id varValue = [self valueForKey:key];   \
NSArray *filters = @[@"superclass", @"description", @"debugDescription", @"hash"]; \
if (varValue && [filters containsObject:key] == NO) { \
[coder encodeObject:varValue forKey:key];   \
}   \
}   \
free(ivarList); \
free(propList); \
cls = class_getSuperclass(cls); \
}   \
}


#define WZLSERIALIZE_COPY_WITH_ZONE()  \
\
/*如果不实现copyWithZone:方法，则[personObject copy]时会崩溃*/   \
- (id)copyWithZone:(NSZone *)zone   \
{   \
NSLog(@"%s",__func__);  \
id copy = [[[self class] allocWithZone:zone] init];    \
Class cls = [self class];   \
while (cls != [NSObject class]) {  \
/*判断是自身类还是父类*/    \
BOOL bIsSelfClass = (cls == [self class]);  \
unsigned int iVarCount = 0; \
unsigned int propVarCount = 0;  \
unsigned int sharedVarCount = 0;    \
Ivar *ivarList = bIsSelfClass ? class_copyIvarList([cls class], &iVarCount) : NULL;/*变量列表，含属性以及私有变量*/   \
objc_property_t *propList = bIsSelfClass ? NULL : class_copyPropertyList(cls, &propVarCount);/*属性列表*/   \
sharedVarCount = bIsSelfClass ? iVarCount : propVarCount;   \
\
for (int i = 0; i < sharedVarCount; i++) {  \
const char *varName = bIsSelfClass ? ivar_getName(*(ivarList + i)) : property_getName(*(propList + i)); \
NSString *key = [NSString stringWithUTF8String:varName];    \
/*valueForKey只能获取本类所有变量以及所有层级父类的属性，不包含任何父类的私有变量(会崩溃)*/  \
id varValue = [self valueForKey:key];   \
NSArray *filters = @[@"superclass", @"description", @"debugDescription", @"hash"]; \
if (varValue && [filters containsObject:key] == NO) { \
[copy setValue:varValue forKey:key];    \
}   \
}   \
free(ivarList); \
free(propList); \
cls = class_getSuperclass(cls); \
}   \
return copy;    \
}


#define WZLSERIALIZE_DESCRIPTION() \
\
/* 用来打印本类的所有变量(成员变量+属性变量)，所有层级父类的属性变量及其对应的值 */  \
- (NSString *)description   \
{   \
NSString  *despStr = @"";   \
Class cls = [self class];   \
while (cls != [NSObject class]) {   \
/*判断是自身类还是父类*/  \
BOOL bIsSelfClass = (cls == [self class]);  \
unsigned int iVarCount = 0; \
unsigned int propVarCount = 0;  \
unsigned int sharedVarCount = 0;    \
Ivar *ivarList = bIsSelfClass ? class_copyIvarList([cls class], &iVarCount) : NULL;/*变量列表，含属性以及私有变量*/   \
objc_property_t *propList = bIsSelfClass ? NULL : class_copyPropertyList(cls, &propVarCount);/*属性列表*/   \
sharedVarCount = bIsSelfClass ? iVarCount : propVarCount;   \
\
for (int i = 0; i < sharedVarCount; i++) {  \
const char *varName = bIsSelfClass ? ivar_getName(*(ivarList + i)) : property_getName(*(propList + i)); \
NSString *key = [NSString stringWithUTF8String:varName];    \
/*valueForKey只能获取本类所有变量以及所有层级父类的属性，不包含任何父类的私有变量(会崩溃)*/  \
id varValue = [self valueForKey:key];   \
NSArray *filters = @[@"superclass", @"description", @"debugDescription", @"hash"]; \
if (varValue && [filters containsObject:key] == NO) { \
despStr = [despStr stringByAppendingString:[NSString stringWithFormat:@"%@: %@\n", key, varValue]]; \
}   \
}   \
free(ivarList); \
free(propList); \
cls = class_getSuperclass(cls); \
}   \
return despStr; \
}


/* 封装归档keyedArchiver操作 */
#define WZLSERIALIZE_ARCHIVE(__objToBeArchived__, __key__, __filePath__)    \
\
NSMutableData *data = [NSMutableData data]; \
NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];   \
[archiver encodeObject:__objToBeArchived__ forKey:__key__];    \
[archiver finishEncoding];  \
[data writeToFile:__filePath__ atomically:YES]


/* 封装反归档keyedUnarchiver操作 */
#define WZLSERIALIZE_UNARCHIVE(__objToStoreData__, __key__, __filePath__)   \
NSMutableData *dedata = [NSMutableData dataWithContentsOfFile:__filePath__]; \
NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:dedata];  \
__objToStoreData__ = [unarchiver decodeObjectForKey:__key__];  \
[unarchiver finishDecoding]


#endif /* SPSerializeKit_h */
