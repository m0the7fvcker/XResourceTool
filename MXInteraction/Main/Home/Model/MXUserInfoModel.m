//
//  MXUserInfoModel.m
//  MXInteraction
//
//  Created by maRk on 16/9/28.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXUserInfoModel.h"

#import "MXUserRoomModel.h"
#import "MXUserKeyBagModel.h"

@implementation MXUserInfoModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"roomList":[MXUserRoomModel class],
             @"myKeyBag":[MXUserKeyBagModel class]};
}

@end
