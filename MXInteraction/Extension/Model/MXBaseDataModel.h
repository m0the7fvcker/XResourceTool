//
//  MXBaseDataModel.h
//  MXInteraction
//
//  Created by maRk on 16/8/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MXRequestCode){
    MXRequestCode_Success = 000000,//成功
    MXRequestCode_Fail = 100000,//失败
    MXRequestCode_RequestRuleError = 100001,//请求方式不正确
    MXRequestCode_UserInfoNotFull = 100002,//身份信息不完整
    MXRequestCode_JsonError = 100003,//JSON解析失败
    MXRequestCode_ParamFormatError = 100004,//参数格式不正确
    MXRequestCode_ParamError = 100005,//参数不正确
    MXRequestCode_UserAlreadyExist = 100006,//用户已存在
    MXRequestCode_UserNotExist = 100007,//用户不存在
    MXRequestCode_PswError = 100008,//密码错误
    MXRequestCode_UserDeactivated = 100009,//账号已停用
    MXRequestCode_IMAccountCreatFail = 100010,//IM账号创建失败
    MXRequestCode_CommunityNotExist = 100011,//小区不存在
    MXRequestCode_ActionError = 100012,//操作失败
    MXRequestCode_VerifyCodeError = 100013,//验证码不正确
    MXRequestCode_UploadFileError = 100014,//上传文件失败
    MXRequestCode_UploadFileFormatError = 100015,//上传文件格式不正确
    MXRequestCode_UploadFileSizeError = 100016,//上传文件大小超过限定
    MXRequestCode_UserNotActived = 300001//账号未激活
};

@interface MXBaseDataModel : NSObject

@property (nonatomic, assign) MXRequestCode status;
@property (nonatomic, assign) NSInteger timestamp;
@property (nonatomic, strong) id data;

@end
