//
//  MXBaseDataModel.h
//  MXInteraction
//
//  Created by maRk on 16/8/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MXRequestCode){
    MXRequestCode_Fail = 0,//失败
    MXRequestCode_Success = 1,//成功
    MXRequestCode_Unlogin = 10,//未登陆
};

@interface MXBaseDataModel : NSObject

@property (nonatomic, assign) MXRequestCode code;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) id data;

@end
