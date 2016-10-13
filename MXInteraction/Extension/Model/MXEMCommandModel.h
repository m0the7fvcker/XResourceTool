//
//  MXEMCommandModel.h
//  MXInteraction
//
//  Created by maRk'sTheme on 2016/10/13.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MXEMCammondActionType){
    MXEMCammondActionType_Call = 301,// 呼叫
    MXEMCammondActionType_Hangup = 302,// 挂断
    MXEMCammondActionType_Open = 303,// 开门
    MXEMCammondActionType_Monitor = 304,// 监视
    MXEMCammondActionType_Answer = 305// 接听
};

typedef NS_ENUM(NSInteger, MXEMCammondType){
    MXEMCammondType_Request = 101,// 请求
    MXEMCammondType_Request_Success = 102,// 应答成功
    MXEMCammondType_Request_Error = 103,// 请求错误
    MXEMCammondType_Request_Busy = 104// 设备繁忙
};

@interface MXEMCommandModel : NSObject

@property (nonatomic, copy) NSString *CommandAction;
@property (nonatomic, copy) NSString *CommandType;
@property (nonatomic, copy) NSString *CommandSendTimeStamp;
@property (nonatomic, copy) NSString *RemoteImKey;
@property (nonatomic, copy) NSString *LocalImKey;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *RemoteDeviceSerial;
@property (nonatomic, copy) NSString *LocalDeviceSerial;
@property (nonatomic, copy) NSString *CommandSequence;
@property (nonatomic, copy) NSString *OtherJSON;

@end
