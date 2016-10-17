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
static NSString *MXUserDefault_UserIMKey = @"userIMKey";
static NSString *MXUserDefault_UserIMPassword = @"userIMPassword";
static NSString *MXUserDefault_UserLocalSerial = @"userLocalSerial";
static NSString *MXUserDefault_UserNoDisturbSetting = @"userNoDisturbSetting";
static NSString *MXUserDefault_UserQRCode = @"userQRCode";

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

+ (void)removeUserAccount
{
    [MXUDStandard removeObjectForKey:MXUserDefault_UserAccount];
}

+ (BOOL)saveUserPassword:(NSString *)password withAccount:(NSString *)account
{
    return [MXKeychain setPassword:password account:account];
}

+ (NSString *)getUserPasswordWithAccount:(NSString *)account
{
    return [MXKeychain passwordWithAccount:account];
}

+ (BOOL)removeUserPassword
{
   return [MXKeychain deletePassword:[self getUserAccount]];
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

+ (void)removeUserSecretKey
{
    [MXUDStandard removeObjectForKey:MXUserDefault_UserSecretKey];
}

+ (void)saveUserIMKey:(NSString *)IMKey
{
    [MXUDStandard setObject:IMKey forKey:MXUserDefault_UserIMKey];
    [MXUDStandard synchronize];
}

+ (NSString *)getUserIMKey
{
    return [MXUDStandard objectForKey:MXUserDefault_UserIMKey];
}

+ (void)removeUserIMKey
{
    [MXUDStandard removeObjectForKey:MXUserDefault_UserIMKey];
}

+ (void)saveUserIMPassword:(NSString *)IMPassword
{
    [MXUDStandard setObject:IMPassword forKey:MXUserDefault_UserIMPassword];
    [MXUDStandard synchronize];
}

+ (NSString *)getUserIMPassword
{
    return [MXUDStandard objectForKey:MXUserDefault_UserIMPassword];
}

+ (void)removeUserIMPassword
{
    [MXUDStandard removeObjectForKey:MXUserDefault_UserIMPassword];
}

+ (void)saveUserLocalDeviceSerial:(NSString *)localSerial
{
    [MXUDStandard setObject:localSerial forKey:MXUserDefault_UserLocalSerial];
    [MXUDStandard synchronize];
}

+ (NSString *)getUserLocalDeviceSerial
{
    return [MXUDStandard objectForKey:MXUserDefault_UserLocalSerial];
}

+ (void)removeUserLocalDeviceSerial
{
    [MXUDStandard removeObjectForKey:MXUserDefault_UserLocalSerial];
}

+ (void)saveUserNoDisturbSetting:(BOOL)noDisturb
{
    [MXUDStandard setBool:noDisturb forKey:MXUserDefault_UserNoDisturbSetting];
    [MXUDStandard synchronize];
}

+ (BOOL)getUserNoDisturbSetting
{
    return [MXUDStandard boolForKey:MXUserDefault_UserNoDisturbSetting];
}

+ (void)removeUserNoDisturbSetting
{
    [MXUDStandard removeObjectForKey:MXUserDefault_UserNoDisturbSetting];
}

+ (void)saveUserQRCode:(NSString *)QRCode
{
    [MXUDStandard setObject:QRCode forKey:MXUserDefault_UserQRCode];
    [MXUDStandard synchronize];
}

+ (NSString *)getUserQRCode
{
    return [MXUDStandard objectForKey:MXUserDefault_UserQRCode];
}

+ (void)removeUserQRCode
{
    [MXUDStandard removeObjectForKey:MXUserDefault_UserQRCode];
}

@end
