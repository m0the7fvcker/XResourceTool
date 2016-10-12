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
 *  @brief 移除用户账户
 *
 *  @return void
 */
+ (void)removeUserAccount;

/**
 *  @brief 保存用户密码
 *
 *  @param account 用户密码
 */
+ (BOOL)saveUserPassword:(NSString *)password withAccount:(NSString *)account;

/**
 *  @brief 取出用户密码
 *
 *  @param account 用户密码
 */
+ (NSString *)getUserPasswordWithAccount:(NSString *)account;

/**
 *  @brief 移除用户密码
 *
 *  @return void
 */
+ (BOOL)removeUserPassword;
/**
 *  @brief 保存用户SecretKey
 *
 *  @param secretKey 用户SecretKey
 */
+ (void)saveUserSecretKey:(NSString *)secretKey;

/**
 *  @brief 取出用户密码
 *
 *  @return account 用户secretKey
 */
+ (NSString *)getUserSecretKey;

/**
 *  @brief 移除用户账户SecretKey
 *
 *  @return void
 */
+ (void)removeUserSecretKey;

/**
 *  @brief 保存用户SecretKey
 *
 *  @param IMKey 用户IMKey
 */
+ (void)saveUserIMKey:(NSString *)IMKey;

/**
 *  @brief 取出用户密码
 *
 *  @return IMKey 用户IMKey
 */
+ (NSString *)getUserIMKey;

/**
 *  @brief 移除用户账户IMKey
 *
 *  @return void
 */
+ (void)removeUserIMKey;

/**
 *  @brief 保存用户SecretKey
 *
 *  @param IMPassword 用户IMPassword
 */
+ (void)saveUserIMPassword:(NSString *)IMPassword;

/**
 *  @brief 取出用户密码
 *
 *  @return IMPassword 用户IMPassword
 */
+ (NSString *)getUserIMPassword;

/**
 *  @brief 移除用户账户IMPassword
 *
 *  @return void
 */
+ (void)removeUserIMPassword;
@end
