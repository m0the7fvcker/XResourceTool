//
//  MXHomeAdModel.h
//  MXInteraction
//
//  Created by maRk on 16/9/28.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXHomeKeyBagPicModel.h"

@interface MXHomeAdModel : NSObject

/** 文件夹地址 */
@property (nonatomic, copy) NSString *folder;
/** 启动广告 */
@property (nonatomic, copy) NSString *startPic;
/** 轮播图 */
@property (nonatomic, strong) NSArray *bannerPic;
/** 钥匙包背景图 */
@property (nonatomic, strong) MXHomeKeyBagPicModel *keyBagPic;
/** 版本号 */
@property (nonatomic, copy) NSString *version;

@end
