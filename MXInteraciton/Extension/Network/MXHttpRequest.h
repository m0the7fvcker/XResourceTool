//
//  MXHttpRequest.h
//  MXInteraction
//
//  Created by maRk on 16/8/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXRequestModel.h"
#import "MXResponseModel.h"

typedef NS_ENUM(NSInteger,MXResponseType) {
    MXResponseType_Json = 0,//返回的文本类型是json
    MXResponseType_Data = 1,//返回的文本类型是Data
    MXResponseType_XML = 2,//返回的文本类型是XML
};

@interface MXHttpRequest : NSObject

/**
 *  Post请求
 *
 *  @param url      请求地址
 *  @param params   参数
 *  @param success  成功回调
 *  @param failure  失败回调
 *
 *  @return 返回MXRequestModel模型
 */
+(nullable MXRequestModel *)POST:(NSString  * _Nonnull)url params:(nullable NSDictionary *)params  success:(nullable void(^)(MXResponseModel * _Nonnull responseModel))success failure:(nullable void(^)( MXResponseModel * _Nonnull  responseModel))failure;


/**
 *  Post请求
 *
 *  @param url      请求地址
 *  @param params   参数
 *  @param progress 进度回调
 *  @param success  成功回调
 *  @param failure  失败回调
 *
 *  @return 返回MXRequestModel模型
 */
+(nullable MXRequestModel *)POST:(NSString  * _Nonnull)url params:(nullable NSDictionary *)params progress:(nullable void (^)(NSProgress * _Nonnull uploadProgress))progress   success:(nullable void(^)( MXResponseModel * _Nonnull responseModel))success failure:(nullable void(^)( MXResponseModel * _Nonnull  responseModel))failure;


/**
 *   Post请求
 *
 *  @param url          请求地址
 *  @param responseType 返回文本类型
 *  @param params       参数
 *  @param progress     进度回调
 *  @param success      成功回调
 *  @param failure      失败回调
 *
 *  @return 返回MXRequestModel模型
 */
+(nullable MXRequestModel *)POST:(NSString  * _Nonnull)url responseType:(MXResponseType)responseType params:(nullable NSDictionary *)params progress:(nullable void (^)(NSProgress * _Nonnull uploadProgress))progress   success:(nullable void(^)( MXResponseModel * _Nonnull responseModel))success failure:(nullable void(^)( MXResponseModel * _Nonnull  responseModel))failure;


/**
 *  Get请求
 *
 *  @param url      请求地址
 *  @param params   参数
 *  @param success  成功回调
 *  @param failure  失败回调
 *
 *  @return 返回MXRequestModel模型
 */
+(nullable MXRequestModel *)GET:(NSString  * _Nonnull)url params:(nullable NSDictionary *)params success:(nullable void(^)( MXResponseModel * _Nonnull responseModel))success failure:(nullable void(^)( MXResponseModel * _Nonnull  responseModel))failure;


/**
 *  Get请求
 *
 *  @param url      请求地址
 *  @param params   参数
 *  @param progress 进度回调
 *  @param success  成功回调
 *  @param failure  失败回调
 *
 *  @return 返回MXRequestModel模型
 */
+(nullable MXRequestModel *)GET:(NSString  * _Nonnull)url params:(nullable NSDictionary *)params progress:(nullable void (^)(NSProgress * _Nonnull uploadProgress))progress success:(nullable void(^)( MXResponseModel * _Nonnull responseModel))success failure:(nullable void(^)( MXResponseModel * _Nonnull  responseModel))failure;


/**
 *  Get请求
 *
 *  @param url          请求地址
 *  @param responseType 返回文本类型
 *  @param params       参数
 *  @param progress     进度回调
 *  @param success      成功回调
 *  @param failure      失败回调
 *
 *  @return 返回MXRequestModel模型
 */
+(nullable MXRequestModel *)GET:(NSString  * _Nonnull)url responseType:(MXResponseType)responseType params:(nullable NSDictionary *)params progress:(nullable void (^)(NSProgress * _Nonnull uploadProgress))progress   success:(nullable void(^)( MXResponseModel * _Nonnull responseModel))success failure:(nullable void(^)( MXResponseModel * _Nonnull  responseModel))failure;


/**
 *  返回主页地址，例如请求 baidu.com/1.jsp 传参是1.jsp 那么host返回的地址应该是 baidu.com或者 baidu.com/。子类重写实现
 *
 *  @return 主页地址
 */
+(NSString * _Nonnull )host;

/**
 *  公共输入参数，子类重写实现
 *
 *  @return 返回字典 默认返回空字典
 */
+(NSDictionary *_Nonnull)publicInputParams;

/**
 *  公共输出参数，子类重写实现
 *
 *  @param param 参数
 */
+(void)publicOutParam:(nullable NSDictionary *)param;
@end
