//
//  MXHttpRequest.m
//  MXInteraction
//
//  Created by maRk on 16/8/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHttpRequest.h"
#import <AFNetworking/AFNetworking.h>

@implementation MXHttpRequest

#pragma mark - 得到会话的唯一实例 防止内存泄漏
+ (AFHTTPSessionManager *)manager
{
    static AFHTTPSessionManager *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [AFHTTPSessionManager manager];
        ///ssl 公开key
        //        _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
    });
    return _manager;
}

#pragma mark - 主页
+ (NSString * _Nonnull)host
{
    return @"http://120.76.216.204/";
}

#pragma mark - 公共参数
+ (NSDictionary * _Nonnull)publicInputParams
{
    return @{};
}

#pragma mark - 公共输出
+ (void)publicOutParam:(nullable NSDictionary *)param
{
    
}

#pragma mark - 请求地址
+ (NSString *)requestUrl:(NSString *)url
{
    NSString *reUrl = [self host];
    reUrl = [reUrl stringByAppendingString:url];
    return reUrl;
}

#pragma mark - 请求参数
+ (NSDictionary *)requestParams:(NSDictionary *)params
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:params];
    [dic  setValuesForKeysWithDictionary:[self publicInputParams]];
    return dic;
}

#pragma mark - POST
+ (nullable MXRequestModel *)POST:(NSString  * _Nonnull)url params:(nullable NSDictionary * )params  success:(nullable void(^)( MXResponseModel * _Nonnull responseModel))success failure:(nullable void(^)( MXResponseModel * _Nonnull  responseModel))failure
{
    return [self POST:url params:params progress:nil success:success failure:failure];;
}


+ (nullable MXRequestModel *)POST:(NSString  * _Nonnull)url params:(nullable NSDictionary * )params progress:(nullable void (^)(NSProgress * _Nonnull uploadProgress))progress   success:(nullable void(^)( MXResponseModel * _Nonnull responseModel))success failure:(nullable void(^)( MXResponseModel * _Nonnull  responseModel))failure
{
    return [self POST:url responseType:MXResponseType_Json params:params progress:progress success:success failure:failure];
}


+ (nullable MXRequestModel *)POST:(NSString  * _Nonnull)url responseType:(MXResponseType)responseType params:(nullable NSDictionary * )params progress:(nullable void (^)(NSProgress * _Nonnull uploadProgress))progress   success:(nullable void(^)( MXResponseModel * _Nonnull responseModel))success failure:(nullable void(^)( MXResponseModel * _Nonnull  responseModel))failure
{
    AFHTTPResponseSerializer *httpResponse = [self getResponseSerializer:responseType];
    AFHTTPSessionManager *manager = [self manager];
    manager.responseSerializer = httpResponse;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *requestUrl = [self requestUrl:url];
    NSDictionary *requestParams = [self requestParams:params];
    NSURLSessionDataTask *task = [manager POST:requestUrl parameters:requestParams progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MXBaseDataModel *baseModel = nil;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            baseModel = [MXBaseDataModel mx_objectWithKeyValues:responseObject];
        }else{
            baseModel = [[MXBaseDataModel alloc]init];
            baseModel.status = MXRequestCode_Fail;
            baseModel.timestamp = 999999;
        }
        MXResponseModel *responseModel = [MXResponseModel newWithTask:task baseModel:baseModel];
        success(responseModel);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MXResponseModel *responseModel = [MXResponseModel newWithTask:task err:error];
        success(responseModel);
    }];
    MXRequestModel *request = [MXRequestModel newWithTask:task];
    return request;
}

#pragma mark - GET
+ (nullable MXRequestModel *)GET:(NSString  * _Nonnull)url params:(nullable NSDictionary * )params success:(nullable void(^)( MXResponseModel * _Nonnull responseModel))success failure:(nullable void(^)( MXResponseModel * _Nonnull  responseModel))failure
{
    return [self GET:url params:params progress:nil success:success failure:failure];
}


+ (nullable MXRequestModel *)GET:(NSString  * _Nonnull)url params:(nullable NSDictionary * )params progress:(nullable void (^)(NSProgress * _Nonnull uploadProgress))progress success:(nullable void(^)( MXResponseModel * _Nonnull responseModel))success failure:(nullable void(^)( MXResponseModel * _Nonnull  responseModel))failure
{
    return [self GET:url responseType:MXResponseType_Json params:params progress:progress success:success failure:failure];
}


+ (nullable MXRequestModel *)GET:(NSString  * _Nonnull)url responseType:(MXResponseType)responseType params:(nullable NSDictionary * )params progress:(nullable void (^)(NSProgress * _Nonnull uploadProgress))progress   success:(nullable void(^)( MXResponseModel * _Nonnull responseModel))success failure:(nullable void(^)( MXResponseModel * _Nonnull  responseModel))failure
{
    AFHTTPResponseSerializer *httpResponse = [self getResponseSerializer:responseType];
    AFHTTPSessionManager *manager = [self manager];
    manager.responseSerializer = httpResponse;
    NSString *requestUrl = [self requestUrl:url];
    NSDictionary *requestParams = [self requestParams:params];
    NSURLSessionDataTask *task = [manager GET:requestUrl parameters:requestParams progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MXBaseDataModel *baseModel = nil;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            baseModel = [MXBaseDataModel mx_objectWithKeyValues:responseObject];
        }else{
            baseModel = [[MXBaseDataModel alloc]init];
            baseModel.status = MXRequestCode_Fail;
            baseModel.timestamp = 999999;
        }
        MXResponseModel *responseModel = [MXResponseModel newWithTask:task baseModel:baseModel];
        success(responseModel);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MXResponseModel *responseModel = [MXResponseModel newWithTask:task err:error];
        success(responseModel);
    }];
    MXRequestModel *request = [MXRequestModel newWithTask:task];
    return request;
}


+ (AFHTTPResponseSerializer *)getResponseSerializer:(MXResponseType)responsetype
{
    AFHTTPResponseSerializer *responseSerializer = [[AFHTTPResponseSerializer alloc]init];
    switch (responsetype) {
        case MXResponseType_XML:
            responseSerializer = [[AFXMLParserResponseSerializer alloc]init];
            break;
        case MXResponseType_Json:
            responseSerializer = [[AFJSONResponseSerializer alloc]init];
            break;
        case MXResponseType_Data:
            responseSerializer = [[AFHTTPResponseSerializer alloc]init];
            break;
        default:
            responseSerializer = [[AFHTTPResponseSerializer alloc]init];
            break;
    }
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    return responseSerializer;
}
@end
