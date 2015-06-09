//
//  NSDate+extend.h
//  NSObject+extend
//
//  Created by Steven on 14/12/16.
//  Copyright (c) 2014年 Neva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NSDate_extend)

/**
 *  聊天界面使用的时间，描述性的时间
 *
 *  @return NSString
 */
-(NSString*)toChatString;

/**
 *  大概的时间，描述性的时间
 *
 *  @return NSString
 */
-(NSString*)toAboutTimeString;

/**
 *  格式化输出时间
 *
 *  @return NSString
 */
-(NSString*)toString;
-(NSString*)toStringWithFormat:(NSString*)pFormat;
+(NSDate*)dateWithString:(NSString*)pDateString;
+(NSDate*)dateWithString:(NSString*)pDateString withFormat:(NSString*)pFormat;

/**
 *  分别获取年、月、日、时、分、秒
 *
 *  @return NSinteger
 */
-(NSInteger)getYear;
-(NSInteger)getMonth;
-(NSInteger)getDay;
-(NSInteger)getHour;
-(NSInteger)getMinute;
-(NSInteger)getSecond;
-(NSInteger)getWeek;

/**
 *  获取年、月、日、星期 的字符串
 *
 *  @return NSString
 */
-(NSString *)getYearString;
-(NSString *)getMonthString;
-(NSString *)getDayString;
-(NSString *)getWeekString;

/**
 *  获取指定年月的起始日期
 *
 *  @param pYear  年份
 *  @param pMonth 月份
 *
 *  @return NSDate
 */
+(NSDate*)getStartDateWithYear:(int)pYear andMonth:(int)pMonth;

/**
 *  获取指定年月的结束日期
 *
 *  @param pYear  年份
 *  @param pMonth 月份
 *
 *  @return NSDate
 */
+(NSDate*)getEndDateWithYear:(int)pYear andMonth:(int)pMonth;

/**
 *  农历转换函数
 *
 *  @param solarDate  NSDate
 *  @param isShowYear 是否输出年份
 *
 *  @return 农历字符串
 */
+(NSString *)lunarForSolar:(NSDate *)solarDate ShowYear:(BOOL)isShowYear;

/**
 *  判断是不是今天
 *
 *  @return YES：是， NO：不是
 */
- (BOOL)isToday;

/**
 *  判断时不是昨天
 *
 *  @return YES：是， NO：不是
 */
- (BOOL)isYesterday;

/**
 *  判断是不是同一天
 *
 *  @param date NSDate
 *
 *  @return YES：是， NO：不是
 */
- (BOOL)isSameDayWithDate:(NSDate*)date;

@end
