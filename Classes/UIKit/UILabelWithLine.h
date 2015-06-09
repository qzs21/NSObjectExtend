//
//  UILabelWithLine.h
//  NSObject+extend
//
//  Created by Steven on 15/3/3.
//  Copyright (c) 2015年 Neva. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    UILabelWithLineTypeNone,//没有画线
    UILabelWithLineTypeUp ,// 上边画线
    UILabelWithLineTypeMiddle,//中间画线
    UILabelWithLineTypeDown,//下边画线
} UILabelWithLineType ;

/// 单行UILabel增加下划线显示
@interface UILabelWithLine : UILabel

/// line type
@property (assign, nonatomic) UILabelWithLineType lineType;

/// is show line.
@property (nonatomic, assign) BOOL showLine;

/// line Color. if self.lineColor == nil, will use self.textColor;
@property (nonatomic, strong) UIColor * lineColor;

@end
