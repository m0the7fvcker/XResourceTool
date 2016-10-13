//
//  MXEMClientTool.h
//  MXInteraction
//
//  Created by maRk on 16/10/11.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXSeeTalkingVC.h"
#import "MXMonitoringVC.h"
#import "MXIncomingVC.h"

#import "MXEMCommandModel.h"

typedef NS_ENUM(NSInteger, MXDeviceState){
    MXDeviceState_Idle = 1, // 空闲
    MXDeviceState_Ringing = 2,// 响铃
    MXDeviceState_Connecting = 3, // 连接
    MXDeviceState_Connected = 4,// 接通
    MXDeviceState_Monitoring = 5 // 监控
};


@interface MXEMClientTool : NSObject

@property (nonatomic, assign) MXDeviceState deviceState;

+ (MXEMClientTool *)shareTool;

/**
 发送指令

 @param cmd 指令
 @param pointIMKey 对方IMKey
 @return 是否发送成功
 */
- (BOOL)sendPointCMD:(MXEMCommandModel *)cmd toPoint:(NSString *)pointIMKey;

/**
 发送群消息，被门禁呼叫时用

 @param cmd 指令
 @param groupID 群ID
 @return 是否发送成功
 */
- (BOOL)sendGroupCMD:(MXEMCommandModel *)cmd toGroup:(NSString *)groupID;


/**
 发送视频

 @param pointIMKey 对方IMKey
 @return 是否发送成功
 */
- (BOOL)sendPointCallTo:(NSString *)pointIMkey;


/**
 发送开门请求

 @param pointIMKey 对方IMKey
 @param remoteSerial 对方Serial
 @return 发送是否成功
 */
- (BOOL)sendOpenRequestCMDToPoint:(NSString *)pointIMKey withRemoteSerial:(NSString *)remoteSerial;


/**
 发送监控请求

 @param pointIMKey 对方IMKey
 @param remoteSerial 对方Serial
 @return 发送是否成功
 */
- (BOOL)sendMonitorRequestCMDToPoint:(NSString *)pointIMKey withRemoteSerial:(NSString *)remoteSerial;


/**
 发送设备空闲状态到群组

 @param groupID 群组ID
 @param remoteSerial 对方Serial
 @param pointKey 对方pointKey
 @return 发送是否成功
 */
- (BOOL)sendIdleStateCMDToGroup:(NSString *)groupID withRemoteSerial:(NSString *)remoteSerial andRemoteIMKey:(NSString *)pointKey;

/**
 发送接收视频消息到群组
 
 @param groupID 群组ID
 @param remoteSerial 对方Serial
 @param pointKey 对方pointKey
 @return 发送是否成功
 */
- (BOOL)sendCallAnswerCMDToGroup:(NSString *)groupID withRemoteSerial:(NSString *)remoteSerial andRemoteIMKey:(NSString *)pointKey;


/**
 发送挂断指令

 @param pointIMKey 对方IMKey
 @param remoteSerial 对方Serial
 @return 发送是否成功
 */
- (BOOL)sendHandupCMDToPoint:(NSString *)pointIMKey withRemoteSerial:(NSString *)remoteSerial;

/**
 发送测试文本消息
 */
- (void)sendMsg;

@end
