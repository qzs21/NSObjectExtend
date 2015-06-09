//
//  NSNumber+extend.m
//  NSObject+extend
//
//  Created by Steven on 15/1/9.
//  Copyright (c) 2015年 Neva. All rights reserved.
//

#import "NSNumber+extend.h"

@implementation NSNumber (NSNumber_extend)

- (NSInteger)length {
    return self.stringValue.length;
}

@end
