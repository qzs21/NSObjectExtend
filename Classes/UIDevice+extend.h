//
//  UIDevice.h
//  NSObject+extend
//
//  Created by Steven on 14/12/8.
//  Copyright (c) 2014年 Neva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice(UIDevice_extend)

/**
 *  获取设备版本信息
 *
 *  @return iPhone1,1
 */
+ (NSString*)platform;

/**
 *  获取设备版本名字
 *
 *  @return iPhone 1G
 */
+ (NSString *)platformString;

/**
 *  app版本
 *
 *  @return app版本
 */
+ (NSString *)appVersion;

/**
 *  app build版本
 *
 *  @return app build版本
 */
+ (NSString *)appBuildVersion;

/**
 *  app名称
 *
 *  @return app名称
 */
+ (NSString *)appName;

/**
 *  获取iOS系统版本号
 */
+ (float)iOSVersion;

@end
