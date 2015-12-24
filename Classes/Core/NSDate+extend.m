//
//  NSDate+extend.m
//  NSObject+extend
//
//  Created by Steven on 14/12/16.
//  Copyright (c) 2014年 Neva. All rights reserved.
//

#import "NSDate+extend.h"
#import "NSECoreConstants.h"

#define NELocalizedString(key, comment) NSLocalizedStringFromTableInBundle(key, @"NSDate_extend", [NSBundle bundleForClass:[NSECoreConstants class]], comment)

@implementation NSDate(NSDate_extend)

-(NSString*)toString {
    return [self toStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

-(NSString*)toStringWithFormat:(NSString*)pFormat{
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:pFormat];
    
    NSString *newDateString = [outputFormatter stringFromDate:self];
    
    return newDateString;
    
}

-(NSString*)toChatString {
    
    NSTimeInterval selftime = [self timeIntervalSince1970];
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    
    NSDate * dd = [NSDate dateWithString:[NSString stringWithFormat:@"%4d-%2d-%2d 00:00",
                                          (int)[[NSDate date] getYear],
                                          (int)[[NSDate date] getMonth],
                                          (int)[[NSDate date] getDay]]
                              withFormat:@"yyyy-MM-dd HH:mm"];
    NSTimeInterval yesterday = [dd timeIntervalSince1970];
    NSTimeInterval todaybefor = yesterday - (3600*24);
    NSTimeInterval daqiantian = todaybefor - (3600*24);
    NSString *str = nil;
    
    
    
    NSString * m = ([self getMonth]>=10)?@"MM":@"M";
    NSString * d = ([self getDay]>=10)?@"dd":@"d";
    NSString * h = ([self getHour]>=10)?@"HH":@"H";
    NSTimeInterval distime = now - selftime;
    if (selftime > now) {  // 将来的时间
        str = [self toStringWithFormat:[NSString stringWithFormat:NELocalizedString(@"yyyy-%@-%@ %@:mm", @"yyyy年%@月%@日 %@:mm"), m, d, h]];
    } else if (selftime < now) {
        if (distime < 5 * 60) {
            str = NELocalizedString(@"just now", @"刚刚");
        } else if (distime < 60 * 10) {
            int m = (int)distime/60;
            if (m == 1) {
                str = [NSString stringWithFormat:NELocalizedString(@"%d minute ago", @"%d分钟前"), m];
            } else {
                str = [NSString stringWithFormat:NELocalizedString(@"%d minutes ago", @"%d分钟前"), m];
            }
        } else  {
            NSString * strhm = [self toStringWithFormat:@"HH:mm"];
            if (selftime > yesterday) {
                str = strhm;
            } else if (selftime <= yesterday && selftime > todaybefor) {
                str = [NSString stringWithFormat:NELocalizedString(@"yesterday %@", @"昨天"), strhm];
            } else if (selftime <= todaybefor && selftime > daqiantian) {
                str = [NSString stringWithFormat:NELocalizedString(@"before yesterday %@", @"前天"), strhm];
            } else if ([[NSDate date] getYear] == [self getYear]) {
                str = [self toStringWithFormat:[NSString stringWithFormat:NELocalizedString(@"%@-%@ %@:mm", @"%@月%@日 %@:mm"), m, d, h]];
            } else {
                str = [self toStringWithFormat:[NSString stringWithFormat:NELocalizedString(@"yyyy-%@-%@ %@:mm", @"yyyy年%@月%@日 %@:mm"), m, d, h]];
            }
        }
    }
    
    return str;
}
-(NSString*)toAboutTimeString {
    NSTimeInterval selftime = [self timeIntervalSince1970];
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    
    NSDate * d = [NSDate dateWithString:[NSString stringWithFormat:@"%4d-%2d-%2d 00:00",
                                         (int)[[NSDate date] getYear],
                                         (int)[[NSDate date] getMonth],
                                         (int)[[NSDate date] getDay]]
                             withFormat:@"yyyy-MM-dd HH:mm"];
    NSTimeInterval yesterday = [d timeIntervalSince1970];
    NSTimeInterval todaybefor = yesterday - (3600*24);
    NSTimeInterval daqiantian = todaybefor - (3600*24);
    NSString *str = nil;
    
    NSTimeInterval distime = now - selftime;
    if (selftime > now) {
        str = NELocalizedString(@"the future", @"将来");
    } else if (selftime <= now) {
        if (distime < 5 * 60) {
            str = NELocalizedString(@"just now", @"刚刚");
        } else if (distime > 25 * 60  && distime < 35*60) {
            return NELocalizedString(@"half an hour ago", @"半小时前");
        } else if (distime < 60 * 60) {
            int m = (int)distime/60;
            if (m == 1) {
                str = [NSString stringWithFormat:NELocalizedString(@"%d minute ago", @"%d分钟前"), m];
            } else {
                str = [NSString stringWithFormat:NELocalizedString(@"%d minutes ago", @"%d分钟前"), m];
            }
        } else  {
            if (selftime > yesterday) {
                str = [self toStringWithFormat:@"HH:mm"];
            } else if (selftime <= yesterday && selftime > todaybefor) {
                str = NELocalizedString(@"yesterday", @"昨天");
            } else if (selftime <= todaybefor && selftime > daqiantian) {
                str = NELocalizedString(@"before yesterday", @"前天");
            } else if (yesterday - selftime <= 60 * 60 * 24 * 15){
                str = [NSString stringWithFormat:NELocalizedString(@"%d days ago", @"%d天前"), (int)( (yesterday - selftime) / (60 * 60 * 24) + 1 )];
            } else if ([[NSDate date] getYear] != [self getYear]) {
                str = [self toStringWithFormat:@"yy-MM-dd"];
            } else {
                str = [self toStringWithFormat:@"MM-dd"];
            }
        }
    }
    
    return str;
}

+(NSDate*)dateWithString:(NSString*)pDateString{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *formatterDate = [inputFormatter dateFromString:pDateString];
    
    return formatterDate;
}

+(NSDate*)dateWithString:(NSString*)pDateString withFormat:(NSString *)pFormat{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:pFormat];
    NSDate *formatterDate = [inputFormatter dateFromString:pDateString];
    
    return formatterDate;
}

-(NSInteger)getYear {
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *weekdayComponents =
    [gregorian components:(NSCalendarUnitYear) fromDate:self];
    NSInteger year = [weekdayComponents year];
    
    return year;
    
}

-(NSInteger)getMonth {
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *weekdayComponents =
    [gregorian components:(NSCalendarUnitMonth) fromDate:self];
    NSInteger month = [weekdayComponents month];
    
    return month;
}

-(NSInteger)getDay {
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *weekdayComponents =
    [gregorian components:(NSCalendarUnitDay) fromDate:self];
    NSInteger day = [weekdayComponents day];
    
    return day;
}

//获取指定日期的星期
-(NSInteger)getWeek {
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *weekdayComponents =
    [gregorian components:(NSCalendarUnitWeekday) fromDate:self];
    NSInteger week = [weekdayComponents weekday];
    
    return week;
}

// 获取星期字符串
-(NSString *)getWeekString {
    NSString* weekStr = nil;
    switch ([self getWeek]) {
        case 1:
            weekStr = NELocalizedString(@"Sunday", @"周日");
            break;
        case 2:
            weekStr = NELocalizedString(@"Monday", @"周一");
            break;
        case 3:
            weekStr = NELocalizedString(@"Tuesday", @"周二");
            break;
        case 4:
            weekStr = NELocalizedString(@"Wednesday", @"周三");
            break;
        case 5:
            weekStr = NELocalizedString(@"Thursday", @"周四");
            break;
        case 6:
            weekStr = NELocalizedString(@"Friday", @"周五");
            break;
        case 7:
            weekStr = NELocalizedString(@"Saturday", @"周六");
            break;
        default:
            break;
    }
    return weekStr ;
}
-(NSString *)getYearString {
    return [NSString stringWithFormat:@"%d", (int)[self getYear]];
}
-(NSString *)getMonthString {
    NSString * str = nil;
    switch ([self getMonth]) {
        case 1:
            str = NELocalizedString(@"January", @"一月");
            break;
        case 2:
            str = NELocalizedString(@"February", @"二月");
            break;
        case 3:
            str = NELocalizedString(@"March", @"三月");
            break;
        case 4:
            str = NELocalizedString(@"April", @"四月");
            break;
        case 5:
            str = NELocalizedString(@"May", @"五月");
            break;
        case 6:
            str = NELocalizedString(@"June", @"六月");
            break;
        case 7:
            str = NELocalizedString(@"July", @"七月");
            break;
        case 8:
            str = NELocalizedString(@"August", @"八月");
            break;
        case 9:
            str = NELocalizedString(@"September", @"九月");
            break;
        case 10:
            str = NELocalizedString(@"October", @"十月");
            break;
        case 11:
            str = NELocalizedString(@"Novemver", @"十一月");
            break;
        case 12:
            str = NELocalizedString(@"December", @"十二月");
            break;
        default:
            break;
    }
    return str;
}
-(NSString *)getDayString {
    return [[NSString stringWithFormat:@"%d", (int)[self getDay]] stringByAppendingString:NELocalizedString(@"day", @"日")];
}


//获取指定日期的时
-(NSInteger)getHour {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *weekdayComponents =
    [gregorian components:(NSCalendarUnitHour) fromDate:self];
    NSInteger Hour = [weekdayComponents hour];
    
    return Hour;
    
}
//获取指定日期的分
-(NSInteger)getMinute {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *weekdayComponents =
    [gregorian components:(NSCalendarUnitMinute) fromDate:self];
    NSInteger minute = [weekdayComponents minute];
    
    return minute;
    
}
//获取指定日期的秒
-(NSInteger)getSecond {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *weekdayComponents =
    [gregorian components:(NSCalendarUnitSecond) fromDate:self];
    NSInteger second = [weekdayComponents second];
    
    return second;
    
}

+(NSDate*)getStartDateWithYear:(int)pYear andMonth:(int)pMonth{
    return [[self class] dateWithString:[NSString stringWithFormat:@"%d-%02d-01 00:00:00",pYear,pMonth]];
}
+(NSDate*)getEndDateWithYear:(int)pYear andMonth:(int)pMonth{
    int tempYear=pYear;
    int tempMonth=pMonth;
    if (pMonth==12) {
        tempYear++;
        tempMonth=1;
    }
    else {
        tempMonth++;
    }
    NSDate *dt=[[self class] dateWithString:[NSString stringWithFormat:@"%d-%02d-01 00:00:00",tempYear,tempMonth]];
    return [NSDate dateWithTimeInterval:-1 sinceDate:dt];
    
}

//农历转换函数
+(NSString *)lunarForSolar:(NSDate *)solarDate ShowYear:(BOOL)isShowYear{
    //天干名称
    NSArray *cTianGan = [NSArray arrayWithObjects:@"甲",@"乙",@"丙",@"丁",@"戊",@"己",@"庚",@"辛",@"壬",@"癸", nil];
    
    //地支名称
    NSArray *cDiZhi = [NSArray arrayWithObjects:@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",nil];
    
    //属相名称
    NSArray *cShuXiang = [NSArray arrayWithObjects:@"鼠",@"牛",@"虎",@"兔",@"龙",@"蛇",@"马",@"羊",@"猴",@"鸡",@"狗",@"猪",nil];
    
    //农历日期名
    NSArray *cDayName = [NSArray arrayWithObjects:@"*",@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",
                         @"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",
                         @"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",@"三十",nil];
    
    //农历月份名
    NSArray *cMonName = [NSArray arrayWithObjects:@"*",@"正",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"腊",nil];
    
    //公历每月前面的天数
    const int wMonthAdd[12] = {0,31,59,90,120,151,181,212,243,273,304,334};
    
    //农历数据
    const int wNongliData[100] = {2635,333387,1701,1748,267701,694,2391,133423,1175,396438
        ,3402,3749,331177,1453,694,201326,2350,465197,3221,3402
        ,400202,2901,1386,267611,605,2349,137515,2709,464533,1738
        ,2901,330421,1242,2651,199255,1323,529706,3733,1706,398762
        ,2741,1206,267438,2647,1318,204070,3477,461653,1386,2413
        ,330077,1197,2637,268877,3365,531109,2900,2922,398042,2395
        ,1179,267415,2635,661067,1701,1748,398772,2742,2391,330031
        ,1175,1611,200010,3749,527717,1452,2742,332397,2350,3222
        ,268949,3402,3493,133973,1386,464219,605,2349,334123,2709
        ,2890,267946,2773,592565,1210,2651,395863,1323,2707,265877};
    
    static NSInteger wCurYear,wCurMonth,wCurDay;
    static NSInteger nTheDate,nIsEnd,m,k,n,i,nBit;
    
    //取当前公历年、月、日
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:solarDate];
    wCurYear = [components year];
    wCurMonth = [components month];
    wCurDay = [components day];
    
    //计算到初始时间1921年2月8日的天数：1921-2-8(正月初一)
    nTheDate = (wCurYear - 1921) * 365 + (wCurYear - 1921) / 4 + wCurDay + wMonthAdd[wCurMonth - 1] - 38;
    if((!(wCurYear % 4)) && (wCurMonth > 2))
        nTheDate = nTheDate + 1;
    
    //计算农历天干、地支、月、日
    nIsEnd = 0;
    m = 0;
    while(nIsEnd != 1)
    {
        if(wNongliData[m] < 4095)
            k = 11;
        else
            k = 12;
        n = k;
        while(n>=0)
        {
            //获取wNongliData(m)的第n个二进制位的值
            nBit = wNongliData[m];
            for(i=1;i<n+1;i++)
                nBit = nBit/2;
            
            nBit = nBit % 2;
            
            if (nTheDate <= (29 + nBit))
            {
                nIsEnd = 1;
                break;
            }
            
            nTheDate = nTheDate - 29 - nBit;
            n = n - 1;
        }
        if(nIsEnd)
            break;
        m = m + 1;
    }
    wCurYear = 1921 + m;
    wCurMonth = k - n + 1;
    wCurDay = nTheDate;
    if (k == 12)
    {
        if (wCurMonth == wNongliData[m] / 65536 + 1)
            wCurMonth = 1 - wCurMonth;
        else if (wCurMonth > wNongliData[m] / 65536 + 1)
            wCurMonth = wCurMonth - 1;
    }
    
    //生成农历天干、地支、属相
    NSString *szShuXiang = (NSString *)[cShuXiang objectAtIndex:((wCurYear - 4) % 60) % 12];
    NSString *szNongli = [NSString stringWithFormat:@"%@(%@%@)年",szShuXiang, (NSString *)[cTianGan objectAtIndex:((wCurYear - 4) % 60) % 10],(NSString *)[cDiZhi objectAtIndex:((wCurYear - 4) % 60) % 12]];
    
    //生成农历月、日
    NSString *szNongliDay;
    if (wCurMonth < 1){
        szNongliDay = [NSString stringWithFormat:@"闰%@",(NSString *)[cMonName objectAtIndex:-1 * wCurMonth]];
    }
    else{
        szNongliDay = (NSString *)[cMonName objectAtIndex:wCurMonth];
    }
    
    NSString *lunarDate = [NSString stringWithFormat:@"%@ %@月 %@",isShowYear?szNongli:@"",szNongliDay,(NSString *)[cDayName objectAtIndex:wCurDay]];
    if (!isShowYear) {
        if (wCurDay==1) {
            return [NSString stringWithFormat:@"%@月",szNongliDay];
        }
        else{
            return (NSString *)[cDayName objectAtIndex:wCurDay];
        }
    }
    
    return lunarDate;
}

// 判断是不是今天
- (BOOL)isToday {
    NSDate * now = [NSDate date];
    if ([self getYear]==[now getYear] &&
        [self getMonth]==[now getMonth] &&
        [self getDay]==[now getDay]) {
        return YES;
    }
    return NO;
}
// 判断是不是昨天
- (BOOL)isYesterday {
    NSDate * dd = [NSDate dateWithString:[NSString stringWithFormat:@"%4d-%2d-%2d 00:00",
                                          (int)[[NSDate date] getYear],
                                          (int)[[NSDate date] getMonth],
                                          (int)[[NSDate date] getDay]]
                              withFormat:@"yyyy-MM-dd HH:mm"];
    NSTimeInterval yesterday = [dd timeIntervalSince1970];
    NSTimeInterval todaybefor = yesterday - (3600*24);
    NSTimeInterval selfTime = [self timeIntervalSince1970];
    if (todaybefor <= selfTime && selfTime < yesterday) {
        return YES;
    }
    return NO;
}
// 判断是不是同一天
-(BOOL)isSameDayWithDate:(NSDate*)date {
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:self];
    
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date];
    
    
    return [comp1 day]   == [comp2 day] &&
    
    [comp1 month] == [comp2 month] &&
    
    [comp1 year]  == [comp2 year];
    
}
@end
