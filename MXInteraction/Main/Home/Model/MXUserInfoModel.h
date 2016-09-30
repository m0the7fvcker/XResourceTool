//
//  MXUserInfoModel.h
//  MXInteraction
//
//  Created by maRk on 16/9/28.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXHomeAdModel.h"

@interface MXUserInfoModel : NSObject

/** 密钥 */
@property (nonatomic, copy) NSString *secretKey;
/** 头像 */
@property (nonatomic, copy) NSString *headSculpture;
/** IM密码 */
@property (nonatomic, copy) NSString *imPassword;
/** IM用户名 */
@property (nonatomic, copy) NSString *imKey;
/** 用户姓名 */
@property (nonatomic, copy) NSString *name;
/** 用户角色 */
@property (nonatomic, copy) NSString *role;
/** 授权房间列表 */
@property (nonatomic, strong) NSArray *roomList;
/** 当前房间名字 */
@property (nonatomic, copy) NSString *roomName;
/** 该房间的钥匙包 */
@property (nonatomic, strong) NSArray *myKeyBag;
/** 授权二维码 */
@property (nonatomic, copy) NSString *qrCode;
/** 小区名称 */
@property (nonatomic, copy) NSString *communityName;
/** 服务器地址 */
@property (nonatomic, copy) NSString *server;
/** APP更新信息 */
@property (nonatomic, copy) NSString *upgrade;
/** 广告图片 */
@property (nonatomic, strong) MXHomeAdModel *advertisement;

@end
