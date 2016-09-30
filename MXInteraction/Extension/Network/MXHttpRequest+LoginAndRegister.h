//
//  MXHttpRequest+LoginAndRegister.h
//  MXInteraction
//
//  Created by maRk on 16/9/28.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHttpRequest.h"

@interface MXHttpRequest (LoginAndRegister)
/**
 获取验证码
 
 @param url     url地址
 @param params  参数为未注册手机号
 @return 返回MXRequestModel
 */
+(nullable MXRequestModel *)GetVerifyCodeWithPhoneNumber:(NSString * _Nonnull)phoneNumber
                                                 success:(nullable void(^)(MXBaseDataModel * _Nonnull responseModel))success
                                                 failure:(nullable void(^)(NSError *     _Nonnull error))failure;

/**
 注册新用户

 @param phoneNumber 手机号
 @param code        验证码
 @param password    密码

 @return 返回MXRequestModel
 */
+(nullable MXRequestModel *)RegisterNewUserWithPhoneNumber:(NSString * _Nonnull)phoneNumber
                                               vierifyCode:(NSString * _Nonnull)code
                                                  password:(NSString * _Nonnull)password
                                                   success:(nullable void(^)(MXBaseDataModel * _Nonnull responseModel))success
                                                   failure:(nullable void(^)(NSError * _Nonnull error))failure;


/**
 用户登录

 @param phoneNumber 手机号
 @param password    密码
 @param appVersion  app版本号

 @return 返回MXRequestModel
 */
+(nullable MXRequestModel *)LoginWithPhoneNumber:(NSString * _Nonnull)phoneNumber
                                        password:(NSString * _Nonnull)password
                                      appVersion:(NSString * _Nonnull)appVersion
                                         success:(nullable void(^)(MXBaseDataModel * _Nonnull responseModel))success
                                         failure:(nullable void(^)(NSError * _Nonnull error))failure;
@end
