//
//  NSObject+extend.m
//  NSObject+extend
//
//  Created by Steven on 14/12/11.
//  Copyright (c) 2014年 Neva. All rights reserved.
//

#import "NSObject+extend.h"
#import "NSDate+extend.h"
#import <objc/runtime.h>

int GetBuildDateTime(char *szDateTime)
{
    const int  MONTH_PER_YEAR=12;
    const char szEnglishMonth[MONTH_PER_YEAR][4]={ "Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
    char szTmpDate[40]={0};
    char szTmpTime[20]={0};
    char szMonth[4]={0};
    int iYear,iMonth,iDay,iHour,iMin,iSec;
    
    //获取编译日期、时间
    sprintf(szTmpDate,"%s",__DATE__); //"Sep 18 2010"
    sprintf(szTmpTime,"%s",__TIME__); //"10:59:19"
    
    sscanf(szTmpDate,"%s %d %d",szMonth,&iDay,&iYear);
    sscanf(szTmpTime,"%d:%d:%d",&iHour,&iMin,&iSec);
    
    for(int i=0;MONTH_PER_YEAR;i++)
    {
        if(strncmp(szMonth,szEnglishMonth[i],3)==0)
        {
            iMonth=i+1;
            break;
        }
    }
    
    //printf("%d,%d,%d,%d,%d,%d\n",iYear,iMonth,iDay,iHour,iMin,iSec);
    sprintf(szDateTime,"%04d%02d%02d%02d%02d%02d",iYear,iMonth,iDay,iHour,iMin,iSec);
    return 0;
}

@implementation NSObject (NSObject_extend)

- (NSString *)JSONString
{
    return [[NSString alloc] initWithData:[self JSONData]  encoding:NSUTF8StringEncoding];
}

- (NSData *)JSONData {
    if (![NSJSONSerialization isValidJSONObject:self])
    {
        return nil;
    }
    return [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:nil];
}

- (id)objectFromJSON
{
    NSData * data = nil;
    if ( [self isKindOfClass:NSString.class] )
    {
        data = [(NSString *)self dataUsingEncoding:NSUTF8StringEncoding];
    }
    else if ( [self isKindOfClass:NSData.class] )
    {
        data = (NSData *)self;
    }
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

+ (NSDate *)buildDate
{
    char szDateTime[15]={0};
    GetBuildDateTime(szDateTime);
    NSString * date = [NSString stringWithUTF8String:szDateTime];
    return [NSDate dateWithString:date withFormat:@"yyyyMMddHHmmss"];
}

+ (BOOL)checkTestTime:(NSTimeInterval)time timeoutTitle:(NSString *)timeoutTitle timeoutMessage:(NSString *)timeoutMessage
{
    NSTimeInterval t = [NSDate.date timeIntervalSinceDate:[self.class buildDate]];
    if (ABS(t) > time && time != 0)
    {
        if (timeoutTitle.length || timeoutMessage.length)
        {
            dispatch_async(dispatch_get_main_queue(), ^
            {
                [[UIApplication sharedApplication] keyWindow].userInteractionEnabled = NO;
                [[UIApplication sharedApplication] keyWindow].alpha = 0;
                [[[UIAlertView alloc] initWithTitle:timeoutTitle
                                            message:timeoutMessage
                                           delegate:nil
                                  cancelButtonTitle:nil
                                  otherButtonTitles:nil, nil] show];
            });
        }
        return YES;
    }
    return NO;
}

static const char* IndexPathKey ="NSObject_UserInfoExtend";
- (void)setUserInfoExtend:(NSIndexPath *)userInfo
{
    objc_setAssociatedObject(self, IndexPathKey, userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (id)userInfoExtend
{
    return (id)objc_getAssociatedObject(self,IndexPathKey);
}

static const char* NSObject_ss_status_Extend ="NSObject_ss_status_Extend";
- (void)setSs_status:(NSInteger)ss_status {
    objc_setAssociatedObject(self, NSObject_ss_status_Extend, @(ss_status), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSInteger)ss_status {
    return [(id)objc_getAssociatedObject(self, NSObject_ss_status_Extend) integerValue];
}


#define mark - Do noce
static const char* NSObject_DoOnceExtend ="NSObject_DoOnceExtend";
- (NSMutableDictionary *)do_once_items
{
    NSMutableDictionary * items = (id)objc_getAssociatedObject(self, NSObject_DoOnceExtend);
    if (items == nil)
    {
        items = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, NSObject_DoOnceExtend, items, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return items;
}
- (void)do_once_with_key:(NSString *)key block:(void(^)(void))block
{
    @synchronized(self.do_once_items)
    {
        if ([[self.do_once_items objectForKey:key] boolValue])
        {
            return;
        }
        block();
        [self.do_once_items setObject:@(YES) forKey:key];
    }
}

@end
