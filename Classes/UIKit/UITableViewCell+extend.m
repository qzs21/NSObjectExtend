//
//  UITableViewCell+extend.m
//  NSObject+extend
//
//  Created by Steven on 15/1/29.
//  Copyright (c) 2015年 Neva. All rights reserved.
//

#import "UITableViewCell+extend.h"
#import "UIView+extend.h"

@implementation UITableViewCell (UITableViewCell_extend)

- (CGFloat)contentViewHeightWithTableViewWidth:(CGFloat)tableViewWidth
{
    return [self.contentView viewHeightWithLimitWidth:tableViewWidth];
}

@end
