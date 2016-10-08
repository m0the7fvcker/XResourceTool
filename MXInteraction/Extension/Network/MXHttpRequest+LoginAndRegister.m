//
//  MXHttpRequest+LoginAndRegister.m
//  MXInteraction
//
//  Created by maRk on 16/9/28.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHttpRequest+LoginAndRegister.h"

@implementation MXHttpRequest (LoginAndRegister)
+(nullable MXRequestModel *)GetVerifyCodeWithPhoneNumber:(NSString * _Nonnull)phoneNumber
                                                 success:(nullable void(^)(MXBaseDataModel * _Nonnull responseModel))success
                                                 failure:(nullable void(^)(NSError *))failure;
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = phoneNumber.length > 0 ? phoneNumber : @"";

    return [self GET:@"api/member/getregisterverifycode" params:params success:^(MXResponseModel * _Nonnull responseModel) {
        success(responseModel.baseModel);
    } failure:^(MXResponseModel * _Nonnull responseModel) {
        NSError *error = responseModel.err;
        failure(error);
    }];
}

+(nullable MXRequestModel *)GetResetVerifyCodeWithPhoneNumber:(NSString * _Nonnull)phoneNumber
                                                      success:(nullable void(^)(MXBaseDataModel * _Nonnull responseModel))success
                                                      failure:(nullable void(^)(NSError *     _Nonnull error))failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = phoneNumber.length > 0 ? phoneNumber : @"";
    
    return [self GET:@"api/member/getcommonverifycode" params:params success:^(MXResponseModel * _Nonnull responseModel) {
        success(responseModel.baseModel);
    } failure:^(MXResponseModel * _Nonnull responseModel) {
        NSError *error = responseModel.err;
        failure(error);
    }];
}

+(nullable MXRequestModel *)ResetPasswordWithPhoneNumber:(NSString * _Nonnull)phoneNumber
                                              verifyCode:(NSString *)code
                                                password:(NSString *)password
                                                 success:(nullable void(^)(MXBaseDataModel * _Nonnull responseModel))success
                                                 failure:(nullable void(^)(NSError *_Nonnull error))failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = phoneNumber.length > 0 ? phoneNumber : @"";
    params[@"code"] = code.length > 0 ? code : @"";
    params[@"password"] = password > 0 ? password : @"";
    
    return [self POST:@"api/member/resetpassword" params:params success:^(MXResponseModel * _Nonnull responseModel) {
        success(responseModel.baseModel);
    } failure:^(MXResponseModel * _Nonnull responseModel) {
        NSError *error = responseModel.err;
        failure(error);
    }];
}

+(nullable MXRequestModel *)RegisterNewUserWithPhoneNumber:(NSString * _Nonnull)phoneNumber
                                               vierifyCode:(NSString * _Nonnull)code
                                                  password:(NSString * _Nonnull)password
                                                   success:(nullable void(^)(MXBaseDataModel * _Nonnull responseModel))success
                                                   failure:(nullable void(^)(NSError * _Nonnull error))failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = phoneNumber.length > 0 ? phoneNumber : @"";
    params[@"code"] = code.length > 0 ? code : @"";
    params[@"password"] = password > 0 ? password : @"";
    
    return [self POST:@"api/member/register" params:params success:^(MXResponseModel * _Nonnull responseModel) {
        success(responseModel.baseModel);
    } failure:^(MXResponseModel * _Nonnull responseModel) {
        NSError *error = responseModel.err;
        failure(error);
    }];
}

+(nullable MXRequestModel *)LoginWithPhoneNumber:(NSString * _Nonnull)phoneNumber
                                        password:(NSString * _Nonnull)password
                                      appVersion:(NSString * _Nonnull)appVersion
                                         success:(nullable void(^)(MXBaseDataModel * _Nonnull responseModel))success
                                         failure:(nullable void(^)(NSError * _Nonnull error))failure
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = phoneNumber.length > 0 ? phoneNumber : @"";
    params[@"password"] = password > 0 ? password : @"";
    
    return [self POST:@"api/member/login" params:params success:^(MXResponseModel * _Nonnull responseModel) {
        success(responseModel.baseModel);
    } failure:^(MXResponseModel * _Nonnull responseModel) {
        NSError *error = responseModel.err;
        failure(error);
    }];
}
@end
