//
//  UILabelWithLine.m
//  NSObject+extend
//
//  Created by Steven on 15/3/3.
//  Copyright (c) 2015年 Neva. All rights reserved.
//

#import "UILabelWithLine.h"

@implementation UILabelWithLine

- (void)drawTextInRect:(CGRect)rect{
    [super drawTextInRect:rect];
    
    if (_showLine) {
        CGSize textSize = [[self text] sizeWithFont:[self font]];
        CGFloat strikeWidth = textSize.width;
        CGRect lineRect;
        CGFloat origin_x = 0.0;
        CGFloat origin_y = 0.0;
        
        
        if ([self textAlignment] == NSTextAlignmentRight) {
            
            origin_x = rect.size.width - strikeWidth;
            
        } else if ([self textAlignment] == NSTextAlignmentCenter) {
            
            origin_x = (rect.size.width - strikeWidth)/2 ;
            
        } else {
            
            origin_x = 0;
        }
        
        
        if (self.lineType == UILabelWithLineTypeUp) {
            
            origin_y =  2;
        }
        
        if (self.lineType == UILabelWithLineTypeMiddle) {
            
            origin_y =  rect.size.height/2;
        }
        
        if (self.lineType == UILabelWithLineTypeDown) {//下画线
            
            origin_y = rect.size.height - 2;
        }
        
        lineRect = CGRectMake(origin_x , origin_y, strikeWidth, 1);
        
        if (self.lineType != UILabelWithLineTypeNone) {
            
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGFloat R, G, B, A;
            UIColor *uiColor = self.lineColor;
            CGColorRef color = [uiColor CGColor];
            size_t numComponents = CGColorGetNumberOfComponents(color);
            
            if( numComponents == 4)
            {
                const CGFloat *components = CGColorGetComponents(color);
                R = components[0];
                G = components[1];
                B = components[2];
                A = components[3];
                
                CGContextSetRGBFillColor(context, R, G, B, 1.0);
                
            }
            
            CGContextFillRect(context, lineRect);
        }
    }
}

- (void)setShowLine:(BOOL)showLine {
    _showLine = showLine;
    [self setNeedsDisplay];
}

@end
