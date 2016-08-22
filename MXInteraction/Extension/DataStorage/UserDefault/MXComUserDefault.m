//
//  MXComUserDefault.m
//  MXInteraction
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXComUserDefault.h"

static NSString *MXUserDefault_IsFristLaunch = @"isFristLaunch";
static NSString *MXUserDefault_HasLogin = @"userHasLogin";

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
@end
