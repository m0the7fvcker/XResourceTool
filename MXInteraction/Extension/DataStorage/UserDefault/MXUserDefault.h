//
//  MXUserDefault.h
//  MXInteraction
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MXUDStandard [NSUserDefaults standardUserDefaults]

@interface MXUserDefault : NSObject

/**
 *  @brief 是否是第一次启动
 *
 *  @return BOOL
 */
+ (BOOL)isFristLaunch;

/**
 *  @brief 设置第一次启动标识
 *
 *  @param isFristLaunch 第一次启动标识
 */
+ (void)setIsFristLaunch:(BOOL)isFristLaunch;

/**
 *  @brief 默认主题
 *
 *  @return 主题的名字
 */
+ (NSString *)defaultTheme;

/**
 *  @brief 设置默认主题
 *
 *  @param defaultTheme 主题名字
 */
+ (void)setDefaultTheme:(NSString *)defaultTheme;

/**
 *  @brief 夜间模式标识
 *
 *  @param isNig 是否是夜间模式
 */
+ (void)setIsNig:(BOOL)isNig;

/**
 *  @brief 夜间模式标识
 *
 *  @return 是否是夜间模式
 */
+ (BOOL)isNig;

/**
 *  @brief 夜间主题的名字
 *
 *  @return 主题的名字
 */
+ (NSString *)nigThemeName;

/**
 *  @brief 设置夜间主题名字
 *
 *  @param themeName 主题名字
 */
+ (void)setNigThemeName:(NSString *)themeName;

/**
 *  @brief 设置主题名字
 *
 *  @param themeName 主题名字
 */
+ (void)setThemeName:(NSString *)themeName;

/**
 *  @brief 得到主题名字
 *
 *  @return 主题名字
 */
+ (NSString *)themeName;
@end
