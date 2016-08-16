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
 * @brief 根据色值得到颜色
 * @param hex 16进制的色值
 **/
+(UIColor *)MX_ColorWithHex:(int)hex;

/**
 * @brief 根据色值得到颜色
 * @param hexString 16进制色值
 **/
+(UIColor *)MX_ColorWithHexString:(NSString *)hexString;

/**
 * @brief 根据色值得到颜色
 * @param hexString 16进制色值
 * @param alpha     透明值
 **/

+(UIColor *)MX_ColorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
@end
