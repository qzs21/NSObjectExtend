//
//  UIImage-Extensions.m
//
//  Created by Hardy Macia on 7/1/09.
//  Copyright 2009 Catamount Software. All rights reserved.
//
#import "UIImage+extend.h"

@implementation UIImage (UIImage_extend)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGSize imageSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}

//截取部分图像
- (UIImage *)imageAtRect:(CGRect)rect {
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
	CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
	
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    
    // 设置图片旋转方向
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef scale:1.0f orientation:self.imageOrientation];
    
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
	
    return smallImage;
}

- (UIImage *)imageResize:(CGSize)reSize {
    
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [self drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

//等比例缩放
- (UIImage *)imageToScale:(CGFloat)scale {
    return [self imageResize:CGSizeMake(self.size.width * scale, self.size.height * scale)];
}

- (UIImage *)autoScaleWithMaxLength:(CGFloat)maxLength {
    
    CGFloat max = MAX(self.size.width, self.size.height);
    CGFloat scale = 1;
    
    if (max > maxLength) {
        scale = maxLength / max;
    }
    
    return [self imageToScale:scale];
}

- (BOOL)writeToFile:(NSString *)aPath {
    if ((self == nil) || (aPath == nil) || ([aPath isEqualToString:@""])) return NO;
    @try
    {
        NSData *imageData = nil;
        NSString *ext = aPath.pathExtension.lowercaseString;
        if ([ext isEqualToString:@"png"]) {
            imageData = UIImagePNGRepresentation(self);
        } else {
            // the rest, we write to jpeg
            // 0. best, 1. lost. about compress.
            imageData = UIImageJPEGRepresentation(self, 1.0);
        }
        if ((imageData == nil) || ([imageData length] <= 0))
            return NO;
        [imageData writeToFile:aPath atomically:YES];
        return YES;
    }
    @catch (NSException *e)
    {
        NSLog(@"create thumbnail exception.");
    }
    return NO;
}

@end
