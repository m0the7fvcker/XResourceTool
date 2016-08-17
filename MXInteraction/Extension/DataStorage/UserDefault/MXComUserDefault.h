//
//  MXComUserDefault.h
//  MXInteraction
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MXUDStandard [NSUserDefaults standardUserDefaults]

@interface MXComUserDefault : NSObject

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

@end