//
//  NSObject+extend.h
//  NSObject+extend
//
//  Created by Steven on 14/12/11.
//  Copyright (c) 2014年 Neva. All rights reserved.
//
//

@interface NSObject (NSObject_extend)


/**
 *  扩展属性，用于保存必要的信息，基本类型请转成对象
 */
@property (nonatomic, strong) id userInfoExtend;

/**
 *  保存某个状态，比如数据模型的选中状态
 */
@property (nonatomic, assign) NSInteger ss_status;

/**
 *  本地对象序列化成json字符串
 *
 *  @return json字符串
 */
- (NSString *)JSONString;

/**
 *  本地对象序列化成json数据流
 *
 *  @return json数据流
 */
- (NSData *)JSONData;

/**
 *  json格式的 NSData 或 NSString 解析成本地对象
 *
 *  @return 本地对象
 */
- (id)objectFromJSON;

/**
 *  获取程序编译时间
 *
 *  @return NSDate
 */
+ (NSDate *)buildDate;

/**
 *  检测测试包超时
 *
 *  *** 记得重新编译，避免编译缓存 ***
 *
 *  @param time           测试的时间长度（从编译日期开始）(单位s), 设置为0时可以永久使用
 *  @param timeoutTitle   超时后弹出UIAlertView的title
 *  @param timeoutMessage 超时后弹出UIAlertView的message
 *
 *  @return 测试包是否超时
 */
+ (BOOL)checkTestTime:(NSTimeInterval)time timeoutTitle:(NSString *)timeoutTitle timeoutMessage:(NSString *)timeoutMessage;


/**************** 
 
 只执行一次的扩展
 
 ****************/

/**
 *  获取当前函数名的字符串,（作为-do_once_with_key:block:的key使用）
 *  使用这个宏生成的key，可以确保块在调用的函数中只执行一次
 */
#define do_once_in_this_function_key [NSString stringWithFormat:@"%s", __FUNCTION__]

/**
 *  在本对象生命周期内，使用key区分，如果key一样，只有第一个调用的位置会被执行，并且只会执行一次
 *
 *  @param key   用于区分的key
 *  @param block 执行的代码块
 */
- (void)do_once_with_key:(NSString *)key block:(void(^)(void))block;

@end