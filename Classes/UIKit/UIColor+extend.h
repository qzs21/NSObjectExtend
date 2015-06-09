//
//  UIColor+extend.h
//  DealExtreme
//
//  Created by xiongcaixing on 10-8-30.
//  Copyright 2010 epro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(UIColor_exetnd)

/**
 *  将十六进制的颜色值转为UIColor
 *
 *  @param hexColor @"#1ec1a3FF"
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHexCode:(NSString *)hexString;

@end
