//
//  MXKeychain.h
//  MXInteraciton
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXKeychain : NSObject

/**
 *  @brief 根据账号得到Keychain存储的密码
 *
 *  @param account 账号
 *
 *  @return 密码
 */
+ (NSString *)passwordWithAccount:(NSString *)account;

/**
 *  @brief 根据账号删除Keychain存储的密码
 *
 *  @param account 账号
 *
 *  @return 删除操作成功与否
 */
+ (BOOL)deletePassword:(NSString *)account;

/**
 *  @brief 将密码存储到keychain
 *
 *  @param password 密码
 *  @param account  账号
 *
 *  @return 存储操作是否成功
 */
+ (BOOL)setPassword:(NSString *)password account:(NSString *)account;
@end
