//
//  UIView+extend.h
//  NSObject+extend
//
//  Created by Steven on 14/12/10.
//  Copyright (c) 2014年 Neva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIView_extend)

@property (nonatomic, assign) CGFloat filletRadius;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat Y;
@property (nonatomic, assign) CGFloat X;

/**
 *  清除所有subView
 */
-(void)clearAllSubView;

/**
 *  获取所有subView
 *
 *  @return UIView Array
 */
-(NSArray *)allSubViews;

/**
 *  遍历所有subView取消其焦点,收回键盘
 */
-(void)resignResponder;

/**
 *  限制 UIView 的宽度，计算出autolayout后的高度
 *
 */
- (CGFloat)viewHeightWithLimitWidth:(CGFloat)limitWidth;

@end
