//
//  UILabelWithBorder.h
//  NSObject+extend
//
//  Created by anddward on 4/29/15.
//  Copyright (c) 2015 Neva. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  一个自带边框的label
 *  ______________________________
 * |                              |
 * |   duang，就这么自信            |
 * |______________________________|
 */
@interface UILabelWithBorder : UILabel
/**
 *  是否需要全部边框
 */
@property (assign,nonatomic) BOOL all;
/**
 *  是否带左边框
 */
@property (assign,nonatomic) BOOL leftBorder;
/**
 *  是否需要右边框
 */
@property (assign,nonatomic) BOOL rightBorder;
/**
 *  是否需要底部边框
 */
@property (assign,nonatomic) BOOL bottomBorder;
/**
 *  是否需要顶部边框
 */
@property (assign,nonatomic) BOOL topBorder;
/**
 *  边框线粗
 */
@property (assign,nonatomic) CGFloat borderWidth;
/**
 *  边框颜色
 */
@property (strong,nonatomic) UIColor* borderColor;
/**
 *  边框距左边的距离
 */
@property (assign,nonatomic) CGFloat borderLeftGap;
/**
 *  边框距右边的距离
 */
@property (assign,nonatomic) CGFloat borderRightGap;
/**
 *  文本距左边的距离
 */
@property (assign,nonatomic) CGFloat textLeftGap;
/**
 *  文本距右边的距离
 */
@property (assign,nonatomic) CGFloat textRightGap;
/**
 *  文本距顶边的距离
 */
@property (assign,nonatomic) CGFloat textTopGap;
/**
 *  文本距底边的距离
 */
@property (assign,nonatomic) CGFloat textBottomGap;

@end
