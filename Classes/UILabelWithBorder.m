//
//  UILabelWithBorder.m
//  NSObject+extend
//
//  Created by anddward on 4/29/15.
//  Copyright (c) 2015 Neva. All rights reserved.
//

#import "UILabelWithBorder.h"

@implementation UILabelWithBorder
/**
 *  添加边框
 */
-(void)drawRect:(CGRect)rect{
    CGContextRef cotx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(cotx, self.borderWidth);
    CGContextSetStrokeColorWithColor(cotx, self.borderColor.CGColor);
    
    CGContextBeginPath(cotx);
    /// top border
    if (self.all || self.topBorder) {
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect)+self.borderLeftGap, CGRectGetMinY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect)-self.borderRightGap, CGRectGetMinY(rect));
        CGContextStrokePath(cotx);
    }
    
    /// bottom border
    if (self.all || self.bottomBorder) {
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect)+self.borderLeftGap, CGRectGetMaxY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect)-self.borderRightGap, CGRectGetMaxY(rect));
        CGContextStrokePath(cotx);
    }
    
    /// left border
    if (self.all || self.leftBorder) {
        CGContextMoveToPoint(cotx, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextStrokePath(cotx);
    }
    
    /// right border
    if (self.all || self.rightBorder) {
        CGContextMoveToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(cotx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        CGContextStrokePath(cotx);
    }
    [super drawRect:rect];
}

/**
 *  控制text缩进
 */
-(void)drawTextInRect:(CGRect)rect{
    rect.origin.x += self.textLeftGap;
    rect.size.width -= self.textRightGap;
    rect.origin.y += self.textTopGap;
    rect.size.height -= self.textBottomGap;
    [super drawTextInRect:rect];
}
@end
