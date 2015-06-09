//
//  UIButton+extend.h
//  NSObject+extend
//
//  Created by Steven on 14/12/15.
//  Copyright (c) 2014年 Neva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (UIButton_extend)

/**
 *  标题
 */
@property (nonatomic) NSString * title;

/**
 *  设置背景色
 *
 *  @param color 背景色
 *  @param state 对应状态
 */
- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

/**
 *  设置下划线
 *  
 *  @param color 下划线颜色, color == nil, 会自动赋上默认值
 *  @param state 对应状态
 */
- (void)setUnderlineWithColor:(UIColor *)color forState:(UIControlState)state;

/**
 *  创建UIButton,根据标题大小自动设置frame.size
 *
 *  @param title  标题
 *  @param target 回调对象
 *  @param action 点击事件
 *
 *  @return UIButton
 */
+ (UIButton *)buttonWithTitle:(NSString *)title target:(id)target touchUpInsideAction:(SEL)action;

/**
 *  创建UIButton,根据normalImage大小自动设置frame.size
 *
 *  @param normalImage      默认图片
 *  @param highlightedImage 高亮图片
 *  @param target           回调对象
 *  @param action           点击事件
 *
 *  @return UIButton
 */
+ (UIButton *)buttonWithNormalImage:(UIImage *)normalImage
                   highlightedImage:(UIImage *)highlightedImage
                             target:(id)target
                touchUpInsideAction:(SEL)action;

@end
