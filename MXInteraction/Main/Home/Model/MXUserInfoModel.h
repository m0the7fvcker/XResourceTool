//
//  MXUserInfoModel.h
//  MXInteraction
//
//  Created by maRk on 16/9/28.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXUserInfoModel : NSObject

@property (nonatomic, strong) NSString *secretKey;
@property (nonatomic, strong) NSString *headSculpture;
@property (nonatomic, strong) NSString *imPassword;
@property (nonatomic, strong) NSString *imKey;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSArray *roomList;
@property (nonatomic, strong) NSString *roomName;
@property (nonatomic, strong) NSArray *myKeyBag;
@property (nonatomic, strong) NSString *qrCode;
@property (nonatomic, strong) NSString *communityName;
@property (nonatomic, strong) NSString *server;
@property (nonatomic, strong) NSString *advertisement;

@end
