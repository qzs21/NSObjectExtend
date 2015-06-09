//
//  CLPlacemark+extend.h
//  ExpressBrother
//
//  Created by Steven on 15/5/3.
//  Copyright (c) 2015年 Neva. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLPlacemark (CLPlacemark_address)

/// 短地址
@property (nonatomic, readonly) NSString * shortAddress;

/// 大概街道位置
@property (nonatomic, readonly) NSString * aboutStreet;

@end