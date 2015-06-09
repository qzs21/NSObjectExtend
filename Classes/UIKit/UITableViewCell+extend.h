//
//  UITableViewCell+extend.h
//  NSObject+extend
//
//  Created by Steven on 15/1/29.
//  Copyright (c) 2015年 Neva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (UITableViewCell_extend)

/**
 *  使用AutoLayout布局时，计算TableViewCell高度
 *
 *  @param tableViewWidth UITableView
 *
 *  @return 计算好的高度
 */
- (CGFloat)contentViewHeightWithTableViewWidth:(CGFloat)tableViewWidth;

@end
