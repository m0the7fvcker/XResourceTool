//
//  MXComUserDefault.m
//  MXInteraction
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXComUserDefault.h"
#import "MXKeychain.h"

static NSString *MXUserDefault_IsFristLaunch = @"isFristLaunch";
static NSString *MXUserDefault_HasLogin = @"userHasLogin";
static NSString *MXUserDefault_UserAccount = @"userAccount";
static NSString *MXUserDefault_UserSecretKey = @"userSecretKey";

@implementation MXComUserDefault

+ (BOOL)isFristLaunch
{
    return [MXUDStandard boolForKey:MXUserDefault_IsFristLaunch];
}

+ (void)setIsFristLaunch:(BOOL)isFristLaunch
{
    [MXUDStandard setBool:isFristLaunch forKey:MXUserDefault_IsFristLaunch];
    [MXUDStandard synchronize];
}

+ (BOOL)hasLogin
{
    return [MXUDStandard boolForKey:MXUserDefault_HasLogin];
}

+ (void)setHasLogin:(BOOL)hasLogin
{
    [MXUDStandard setBool:hasLogin forKey:MXUserDefault_HasLogin];
    [MXUDStandard synchronize];
}

+ (void)saveUserAccount:(NSString *)account
{
    [MXUDStandard setObject:account forKey:MXUserDefault_UserAccount];
    [MXUDStandard synchronize];
}

+ (NSString *)getUserAccount
{
    return [MXUDStandard objectForKey:MXUserDefault_UserAccount];
}

+ (BOOL)saveUserPassword:(NSString *)password withAccount:(NSString *)account
{
    return [MXKeychain setPassword:password account:account];
}

+ (NSString *)getUserPasswordWithAccount:(NSString *)account
{
    return [MXKeychain passwordWithAccount:account];
}

+ (void)saveUserSecretKey:(NSString *)secretKey
{
    [MXUDStandard setObject:secretKey forKey:MXUserDefault_UserSecretKey];
    [MXUDStandard synchronize];
}

+ (NSString *)getUserSecretKey
{
    return [MXUDStandard objectForKey:MXUserDefault_UserSecretKey];
}
@end
