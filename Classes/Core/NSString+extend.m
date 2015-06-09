//
//  NSString+extend.m
//  NSObject+extend
//
//  Created by Steven on 14/12/16.
//  Copyright (c) 2014年 Neva. All rights reserved.
//

#import "NSString+extend.h"

/**
 *  拼接url参数
 */
#define URL_ARRAY_PARAM(string, value) (string.length?[string stringByAppendingFormat:@",%@",value]:value)

@implementation NSString (NSString_extend)

+ (BOOL)matche:(NSString *)format string:(NSString *)string {
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", format];
    return [emailTest evaluateWithObject:string];
}

/// 0~9 a~z A~Z _ -    一般用于用户名, 或密码
-(BOOL)checkUserName {
    NSString * format = @"^([a-zA-Z0-9]|[_]|[-])+$";
    return [self.class matche:format string:self];
}

- (BOOL)isNewVersion:(NSString *)version {
    NSArray * arr1 = [self componentsSeparatedByString:@"."];
    NSArray * arr2 = [version componentsSeparatedByString:@"."];
    
    BOOL isNew = NO;
    for (NSInteger i = 0; i < arr1.count; i++) {
        if (i < arr2.count) {
            if ([arr1[i] intValue] < [arr2[i] intValue]) {
                isNew = YES;
                break;
            }
        }
    }
    
    if (!isNew && arr1.count < arr2.count) {
        for (NSInteger i = arr1.count; i < arr2.count; i++) {
            if ([arr2[i] intValue] > 0) {
                isNew = YES;
                break;
            }
        }
    }
    
    return isNew;
}

-(BOOL)isValidateEmail{
    NSString * format = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self.class matche:format string:self];
}

-(BOOL)isChinaMobileNumber{
    NSString * format = @"^((\\+86)|(86))?[1][3-8]\\d{9}$";
    return  [self.class matche:format string:self];
}

-(BOOL)isCharacterOrNumber{
    NSString * format = @"^[A-Za-z0-9]+$";
    return [self.class matche:format string:self];
}

-(BOOL)isChinese{
    NSString * format = @"^[\u4e00-\u9fa5]+$";
    return [self.class matche:format string:self];
}

-(BOOL)isNumber{
    NSString * format = @"^[0-9]+$";
    return [self.class matche:format string:self];
}

-(BOOL)isChinCharOrNum{
    NSString * format = @"^[A-Za-z0-9\u4e00-\u9fa5]+$";
    return [self.class matche:format string:self];
}

-(BOOL)isChineseOrChar{
    NSString * format = @"^[A-Za-z\u4e00-\u9fa5]+$";
    return [self.class matche:format string:self];
}

-(BOOL)isIpAddress {
    NSString * format = @"^(([0-2]*[0-9]+[0-9]+).([0-2]*[0-9]+[0-9]+).([0-2]*[0-9]+[0-9]+).([0-2]*[0-9]+[0-9]+))$";
    return [self.class matche:format string:self];
}

-(BOOL)isSameSubNetworkWithIP:(NSString *)ip {
    if ([self isIpAddress] && [ip isIpAddress]) {
        NSArray * array = [self componentsSeparatedByString:@"."];
        NSArray * ipArray = [ip componentsSeparatedByString:@"."];
        int i = 0;
        for (NSString * s in array) {
            if (![s isEqualToString:[ipArray objectAtIndex:i]]) {
                break;
            }
            i++;
        }
        if (i == 3) {
            return YES;
        }
    }
    return NO;
}

/*字符串中是否包涵Emoji表情*/
- (BOOL)isHaveEmojiString {
    __block BOOL returnValue = NO;
    NSString * string = self;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

/* 是否普通车牌号 */
- (BOOL)isNomalPlateNumber{
    NSString * format = @"^\\w{5}$";
    return [self.class matche:format string:self];
}

/* 是否教练车车牌号 */
- (BOOL)isLearningPlateNumber{
    NSString * format = @"^\\w{4}学$";
    return [self.class matche:format string:self];
}

/*  是否车架号 */
- (BOOL)isVin{
    NSString * format = @"^\\w{17}$";
    return [self.class matche:format string:self];
}

/*  是否发动机号  */
- (BOOL)isEnginNumber{
    NSString * format = @"^\\w{6,}$";
    return [self.class matche:format string:self];
}

/* 一百以内整数转中文字符串 */
+ (NSString *)intToChineseString:(int)number {
    NSArray * item = @[@"零", @"一", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"十"];
    if (number >= 20) {
        NSString * str = item[(int)number/(int)10];
        str = [str stringByAppendingString:@"十"];
        int d = (int)number%(int)10;
        if (d) {
            str = [str stringByAppendingString:IntToString(d)];
        }
        return str;
    } else if (number < 20 && number > 10) {
        NSString * str = @"十";
        int d = (int)number%(int)10;
        if (d) {
            str = [str stringByAppendingString:item[d]];
        }
        return str;
    } else {
        return item[number];
    }
}


+(NSString *)urlArrayParam:(NSArray *)items {
    NSString * string = nil;
    for (NSString * str in items) {
        string = URL_ARRAY_PARAM( string, str );
    }
    return string;
}

/// 秒数转描述性时间, ex. 3天5小时3分钟
+(NSString *)secondsToDateString:(NSInteger)time {
    int t = (int)time;
    int d = t / 3600 / 24;
    int h = t % (3600 * 24) / 3600;
    int m = t % 3600 / 60;
    if (d > 0 && h > 0) {
        return [self.class stringWithFormat:@"%d天%d小时%d分钟", d, h, m];
    } else if (h > 0) {
        return [self.class stringWithFormat:@"%d小时%d分钟", h, m];
    } else {
        return [self.class stringWithFormat:@"%d分钟", m];
    }
}

@end
