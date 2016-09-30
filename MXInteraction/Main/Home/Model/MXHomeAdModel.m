//
//  MXHomeAdModel.m
//  MXInteraction
//
//  Created by maRk on 16/9/28.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHomeAdModel.h"
#import "MXHomeBannerModel.h"

@implementation MXHomeAdModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"bannerPic":[MXHomeBannerModel class],
             };
}
@end
