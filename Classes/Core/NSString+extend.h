//
//  NSString+extend.h
//  NSObject+extend
//
//  Created by Steven on 14/12/16.
//  Copyright (c) 2014年 Neva. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 数字转字符串，快捷宏
#define IntToString(value)              [NSString stringWithFormat:@"%d", (int)(value)]
#define FloatToString(value)            [NSString stringWithFormat:@"%f", (float)(value)]
#define DoubleToString(value)           [NSString stringWithFormat:@"%lf", (double)(value)]
#define BOOLToString(value)             IntToString(value)


/**
 *  保证字符串长度不为0
 *
 *  @param __str     需要检测的字符串
 *  @param __replace 用来替换的字符串
 *
 *  @return 如果__str长度为0，返回__replace, 否则返回__str
 */
#define NO_EMPTY_STRING_REPLACE(__str, __replace)   ( [(__str) length] ? (__str) : (__replace) )

/**
 *  保证字符串长度不为0
 *
 *  @param __str 需要检测的字符串
 *
 *  @return 如果字符串长度为0，返回 @"-", 否则返回__str
 */
#define NO_EMPTY_STRING(__str)                      NO_EMPTY_STRING_REPLACE(__str, @"-")


/**
 *  返回安全字符串，确保字符串非空，一般用于插入字典前
 *
 *  @param str NSString
 *
 *  @return NSString
 */
#define SAVE_STRING(str)   (((str)&&![(str) isKindOfClass:NSNull.class])?[NSString stringWithFormat:@"%@",(str)]:@"")


/**
 *  字符串拼接
 *
 *  @param str1 字符串一，允许为空
 *  @param str2 字符串二，允许为空
 *
 *  @return 返回拼接好的字符串
 */
#define STRCAT(str1, str2)  [SAVE_STRING(str1) stringByAppendingString:SAVE_STRING(str2)]


@interface NSString (NSString_Math)

/// 匹配由数字、26个英文字母或者下划线组成的字符串, 一般用于用户名, 或密码
-(BOOL)checkUserName;

/**
 *  判断字符串是否为更新版本
 *
 *  @param version  exp：1.0.1 , 1.0.2
 *
 *  @return YES 为新版
 */
- (BOOL)isNewVersion:(NSString *)version;

/**
 *  是否合法email地址
 *
 *  @return YES是
 */
-(BOOL)isValidateEmail;

/**
 *  是否中国手机号码, 兼容 +86 86 形式前缀, 中间不能有空格
 *
 *  @return YES是
 */
-(BOOL)isChinaMobileNumber;

/**
 *  是否英文或数字组成
 *
 *  @return YES是
 */
-(BOOL)isCharacterOrNumber;

/**
 *  是否中文
 *
 *  @return YES是
 */
-(BOOL)isChinese;

/**
 *  是否数字
 *
 *  @return YES是
 */
-(BOOL)isNumber;

/**
 *  是否中文或数字组成
 *
 *  @return YES是
 */
-(BOOL)isChinCharOrNum;

/**
 *  是否中文或英文字母组成
 *
 *  @return YES是
 */
-(BOOL)isChineseOrChar;

/**
 *  是否IP地址
 *
 *  @return YES是
 */
-(BOOL)isIpAddress;

/**
 *  判断self与指定ip是否同一网段
 *
 *  @param ip 需要比较的ip
 *
 *  @return YES表示是同一网段
 */
-(BOOL)isSameSubNetworkWithIP:(NSString *)ip;

/**
 *  判断是否包含Emoji表情
 *
 *  @return YES表示包含
 */
- (BOOL)isHaveEmojiString;

/**
 *  是否普通车牌号（蓝牌车和大型黄牌车）,不含前缀，5位数字或字母
 *
 *  @return YES 是
 */
- (BOOL)isNomalPlateNumber;

/**
 *  是否教练车车牌号（包含“学”子）,不含前缀，5位数字或字母
 *
 *  @return YES 是
 */
- (BOOL)isLearningPlateNumber;

/**
 *  是否车架号
 *
 *  @return YES 是
 */
- (BOOL)isVin;

/**
 *  是否发动机号
 *
 *  @return YES 是
 */
- (BOOL)isEnginNumber;

/**
 *  一百以内整数转中文字符串
 *
 *  @param number 100以内整数
 *
 *  @return 中文字符串
 */
+ (NSString *)intToChineseString:(int)number;

/**
 *  url数组参数
 *
 *  @param items 字符串数组
 *
 *  @return 返回拼接好的字符串 exp: 1,2,3,4
 */
+(NSString *)urlArrayParam:(NSArray *)items;

/// 秒数转描述性时间, ex. 3天5小时3分钟
+(NSString *)secondsToDateString:(NSInteger)time;

@end
