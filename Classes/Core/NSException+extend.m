//
//  NSException+extend.m
//  NSObject+extend
//
//  Created by Steven on 15/4/24.
//  Copyright (c) 2015年 Neva. All rights reserved.
//

#import "NSException+extend.h"
#import "NSDate+extend.h"
#import "NSObjectMacro.h"
#import <objc/runtime.h>

/// 已处理的日志目录
#define LOG_FILE_DIR_NEW    @"catch_exception/new"
/// 未处理的日志目录
#define LOG_FILE_DIR_OLD    @"catch_exception/old"

/// 异常处理对象
@interface HandleExceptionObject: NSObject
@property (nonatomic, strong) UncatchExceptionHandlerBlock handlerBlock;
@end
@implementation HandleExceptionObject

LX_GTMOBJECT_SINGLETON_BOILERPLATE(HandleExceptionObject);

+ (NSString *)GetPathForCaches:(NSString *)filename {
    NSArray * Paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * path = [Paths objectAtIndex:0];
    return [path stringByAppendingPathComponent:filename];
}

// 处理异常
- (void)catchException:(NSException *)e {
    NSString * logString = e.logString;
    // TODO 保存日志
    NSLog(@"%@", logString);
    [self callBackHandle];
}

- (void)uncaughtExceptionHandler:(NSException *)exception {
    
    // 异常的堆栈信息
    NSArray *stackArray = [exception callStackSymbols];
    
    // 出现异常的原因
    NSString *reason = [exception reason];
    
    // 异常名称
    NSString *name = [exception name];
    
    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception reason：%@\nException name：%@\nException stack：%@",name, reason, stackArray];
    
    NSLog(@"%@", exceptionInfo);
    
    NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:stackArray];
    
    [tmpArr insertObject:reason atIndex:0];
    
    //保存到本地  --  当然你可以在下次启动的时候，上传这个log
    
//    [exceptionInfo writeToFile:[NSString stringWithFormat:@"%@/Documents/error.log",NSHomeDirectory()]  atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
}

// 回调未处理的日志
- (void)callBackHandle {
    // TODO
}

@end

void UncatchExceptionHandlerFunction(NSException *e) {
//    [[HandleExceptionObject shared] uncaughtExceptionHandler:e];
    [[HandleExceptionObject shared] catchException:e];
}

/// NSException扩展
@implementation NSException (NSException_extend)

- (NSString *)logString {
    NSString * format = @"Date: %@\n*** Terminating app due to uncaught exception '%@', reason: '%@'\n*** First throw call stack:\n%@";
    return [NSString stringWithFormat:format, [[NSDate date] toString],[self name], [self reason], [self callStackSymbols]];
}

+ (void)startUncatchExceptionWithHandlerBlock:(UncatchExceptionHandlerBlock)block {
    // 设置回调块
    [HandleExceptionObject shared].handlerBlock = block;
    // 启动捕获
    NSSetUncaughtExceptionHandler(&UncatchExceptionHandlerFunction);
}

@end
