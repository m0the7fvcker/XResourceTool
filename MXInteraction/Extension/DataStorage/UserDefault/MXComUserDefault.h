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
/**
 *  @brief 判断用户是否已经登录
 *
 *  @return BOOL
 */

+ (BOOL)hasLogin;
/**
 *  @brief 设置用户登录
 *
 *  @param hasLogin 用户是否登录标识
 */
+ (void)setHasLogin:(BOOL)hasLogin;

/**
 *  @brief 保存用户账户
 *
 *  @param account 用户账户
 */
+ (void)saveUserAccount:(NSString *)account;

/**
 *  @brief 取出用户账户
 *
 *  @param account 用户账户
 */
+ (NSString *)getUserAccount;

/**
 *  @brief 保存用户密码
 *
 *  @param account 用户密码
 */
+ (void)saveUserPassword:(NSString *)password withAccount:(NSString *)account;

/**
 *  @brief 取出用户密码
 *
 *  @param account 用户密码
 */
+ (NSString *)getUserPasswordWithAccount:(NSString *)account;

@end
