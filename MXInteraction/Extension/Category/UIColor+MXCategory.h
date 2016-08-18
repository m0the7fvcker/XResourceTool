//
//  UIColor+MXCategory.h
//  MXInteraction
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MXCategory)
/**
 * 根据色值得到颜色
 * @param hex 16进制的色值
 **/
+ (UIColor *)mx_colorWithHex:(int)hex;

/**
 * 根据色值得到颜色
 * @param hexString 16进制色值
 **/
+ (UIColor *)mx_colorWithHexString:(NSString *)hexString;

/**
 * 根据色值得到颜色
 * @param hexString 16进制色值
 * @param alpha     透明值
 **/

+ (UIColor *)mx_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
/**
 *  返回随机色
 */
+ (UIColor *)mx_randomColor;
@end
