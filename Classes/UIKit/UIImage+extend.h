//
//  UIImage-Extensions.h
//
//  Created by Hardy Macia on 7/1/09.
//  Copyright 2009 Catamount Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImage_extend)

/**
*  使用颜色生成1*1的图像
*
*  @param color UIColor
*
*  @return UIImage
*/
+ (UIImage *)imageWithColor:(UIColor *)color;


/**
 *  截取部分图像，包括旋转
 *
 *  @param rect 截取区域
 *
 *  @return 截取出来的UIImage对象
 */
- (UIImage *)imageAtRect:(CGRect)rect;

/**
 *  生成重新调整大小的图像
 *
 *  @param reSize 新大小
 *
 *  @return UIImage
 */
- (UIImage *)imageResize:(CGSize)reSize;

/**
 *  生成等比例缩放图片
 *
 *  @param scale 缩放比例
 *
 *  @return 缩放后的UIImage对象
 */
- (UIImage *)imageToScale:(CGFloat)scale;


/**
 *  限制图片的最大长度,自动将最长边限制在maxLength之内，另一个边等比缩放
 *
 *  @param maxLength 最长边
 *
 *  @return UIImage
 */
- (UIImage *)autoScaleWithMaxLength:(CGFloat)maxLength;

/**
 *  保存UIImage对象到文件，jpg、png，通过路径文件后缀名保存格式
 *
 *  @param aPath 保存的绝对路径
 *
 *  @return 保存成功返回YES
 */
- (BOOL)writeToFile:(NSString *)aPath;




@end