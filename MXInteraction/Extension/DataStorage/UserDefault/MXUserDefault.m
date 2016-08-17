//
//  MXUserDefault.m
//  MXInteraction
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXUserDefault.h"

static NSString *MXUserDefault_isNig         = @"isNig";
static NSString *MXUserDefault_themeName     = @"themeName";
static NSString *MXUserDefault_isFristLaunch = @"isFristLaunch";
static NSString *MXUserDefault_defaultTheme  = @"defaultTheme";
static NSString *MXUserDefault_nigThemeName  = @"nigThemeName";

@implementation MXUserDefault

+ (BOOL)isFristLaunch{
    return [MXUDStandard boolForKey:MXUserDefault_isFristLaunch];
}

+ (void)setIsFristLaunch:(BOOL)isFristLaunch{
    [MXUDStandard setBool:isFristLaunch forKey:MXUserDefault_isFristLaunch];
    [MXUDStandard synchronize];
}

+ (NSString *)defaultTheme{
    return [MXUDStandard objectForKey:MXUserDefault_defaultTheme];
}

+ (void)setDefaultTheme:(NSString *)defaultTheme{
    [MXUDStandard setObject:defaultTheme forKey:MXUserDefault_defaultTheme];
    [MXUDStandard synchronize];
}

+ (BOOL)isNig{
    return [MXUDStandard boolForKey:MXUserDefault_isNig];
}

+ (NSString *)nigThemeName{
    return [MXUDStandard objectForKey:MXUserDefault_nigThemeName];
}

+ (void)setNigThemeName:(NSString *)themeName{
    [MXUDStandard setObject:themeName forKey:MXUserDefault_nigThemeName];
    [MXUDStandard synchronize];
}

+ (void)setIsNig:(BOOL)isNig{
    [MXUDStandard setBool:isNig forKey:MXUserDefault_isNig];
    [MXUDStandard synchronize];
}

+ (void)setThemeName:(NSString *)themeName{
    [MXUDStandard setObject:themeName forKey:MXUserDefault_themeName];
    [MXUDStandard synchronize];
}

+ (NSString *)themeName{
    return [MXUDStandard objectForKey:MXUserDefault_themeName];
}

@end
