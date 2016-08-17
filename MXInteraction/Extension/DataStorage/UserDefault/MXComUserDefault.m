//
//  MXComUserDefault.m
//  MXInteraction
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXComUserDefault.h"

static NSString *MXUserDefault_isFristLaunch = @"isFristLaunch";

@implementation MXComUserDefault

+ (BOOL)isFristLaunch{
    return [MXUDStandard boolForKey:MXUserDefault_isFristLaunch];
}

+ (void)setIsFristLaunch:(BOOL)isFristLaunch{
    [MXUDStandard setBool:isFristLaunch forKey:MXUserDefault_isFristLaunch];
    [MXUDStandard synchronize];
}

@end
