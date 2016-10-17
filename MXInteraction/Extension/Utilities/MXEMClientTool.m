//
//  MXEMClientTool.m
//  MXInteraction
//
//  Created by maRk on 16/10/11.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXEMClientTool.h"
#import "MXIncomingVC.h"

#import "MXOpenRecordModel.h"
#import "MXAppDelegate.h"

#import "MXJSONTool.h"

@interface MXEMClientTool()<EMChatManagerDelegate, EMCallManagerDelegate, EMGroupManagerDelegate>

@property (nonatomic, strong) EMCallSession *callSession;
@property (nonatomic, strong) MXMonitoringVC *monitorVC;

@end

@implementation MXEMClientTool

+ (MXEMClientTool *)shareTool
{
    static MXEMClientTool *_tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool = [[MXEMClientTool alloc] init];
    });
    return _tool;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self initTool];
    }
    return self;
}

- (void)initTool
{
//    [[EMClient sharedClient] addDelegate:self];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].callManager addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].groupManager addDelegate:self delegateQueue:nil];
}

- (void)dealloc
{
//    [[EMClient sharedClient] removeDelegate:self];
    [[EMClient sharedClient].callManager removeDelegate:self];
    [[EMClient sharedClient].groupManager removeDelegate:self];
    [[EMClient sharedClient].chatManager removeDelegate:self];
}

- (void)sendMsg
{
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:@"111"];
    NSString *from = [[EMClient sharedClient] currentUsername];
    //ef131bc92b73ebee7f12d71611ff6898
    EMMessage *message = [[EMMessage alloc] initWithConversationID:@"maxiao1" from:from to:@"maxiao1" body:body ext:nil];
    
    [[EMClient sharedClient].chatManager sendMessage:message progress:nil completion:^(EMMessage *message, EMError *error) {
        if (!error) {
            NSLog(@"发送成功");
        }
        else {
            NSLog(@"发送失败");
        }
    }];
}

- (BOOL)sendPointCMD:(MXEMCommandModel *)cmd toPoint:(NSString *)pointIMKey
{
    NSString *cmdJSON = [cmd mx_JSONString];
    EMCmdMessageBody *body = [[EMCmdMessageBody alloc] initWithAction:cmdJSON];
    
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    EMMessage *message = [[EMMessage alloc] initWithConversationID:pointIMKey from:from to:pointIMKey body:body ext:nil];
    message.chatType = EMChatTypeChat;
    
    __block BOOL sendStataus;
    [[EMClient sharedClient].chatManager sendMessage:message progress:nil completion:^(EMMessage *aMessage, EMError *aError) {
        if (!aError) {
            sendStataus = YES;
            NSLog(@"发送成功");
        }
        else {
            sendStataus = NO;
            NSLog(@"发送失败");
        }
    }];
    
    return sendStataus;
}

- (BOOL)sendGroupCMD:(MXEMCommandModel *)cmd toGroup:(NSString *)groupID;
{
    NSString *cmdJSON = [cmd mx_JSONString];
    EMCmdMessageBody *body = [[EMCmdMessageBody alloc] initWithAction:cmdJSON];
    
    NSString *from = [[EMClient sharedClient] currentUsername];
    EMMessage *message = [[EMMessage alloc] initWithConversationID:groupID from:from to:groupID body:body ext:nil];
    message.chatType = EMChatTypeGroupChat;
    
    __block BOOL sendStataus;
    [[EMClient sharedClient].chatManager sendMessage:message progress:nil completion:^(EMMessage *aMessage, EMError *aError) {
        if (!aError) {
            sendStataus = YES;
            NSLog(@"发送成功");
        }
        else {
            sendStataus = NO;
            NSLog(@"发送失败");
        }
    }];
    
    return sendStataus;
}

- (BOOL)sendPointCallTo:(NSString *)to
{
    __block BOOL sendStatus;
    [[EMClient sharedClient].callManager startVideoCall:to completion:^(EMCallSession *aCallSession, EMError *aError) {
        if (!aError && aCallSession) {
            sendStatus = YES;
            _callSession = aCallSession;
            NSLog(@"发送视频成功");
            MXIncomingVC *callVC = [[MXIncomingVC alloc] initWithSessicon:aCallSession andIsCaller:YES];
            self.incomingVC = callVC;
            [MXAppDelegateAccessor.window.rootViewController presentViewController:callVC animated:YES completion:nil];
        }else {
            sendStatus = NO;
            NSLog(@"发送视频失败");
        }
    }];
    return sendStatus;
}

- (BOOL)sendOpenRequestCMDToPoint:(NSString *)pointIMKey withRemoteSerial:(NSString *)remoteSerial
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    long timeStamp = (long)interval;
    
    MXEMCommandModel *openCMD = [[MXEMCommandModel alloc] init];
    openCMD.CommandAction = @"303";
    openCMD.CommandType = @"101";
    openCMD.CommandSendTimeStamp = [NSString stringWithFormat:@"%ld",timeStamp];
    openCMD.RemoteImKey = pointIMKey;
    openCMD.LocalImKey = [EMClient sharedClient].currentUsername;
    openCMD.tag = @"command";
    openCMD.RemoteDeviceSerial = remoteSerial;
    openCMD.LocalDeviceSerial = [MXComUserDefault getUserLocalDeviceSerial];
    openCMD.CommandSequence = @"1";
    openCMD.OtherJSON = @"";
    
    return [self sendPointCMD:openCMD toPoint:pointIMKey];
}

- (BOOL)sendMonitorRequestCMDToPoint:(NSString *)pointIMKey withRemoteSerial:(NSString *)remoteSerial
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    long timeStamp = (long)interval;
    
    MXEMCommandModel *openCMD = [[MXEMCommandModel alloc] init];
    openCMD.CommandAction = @"304";
    openCMD.CommandType = @"101";
    openCMD.CommandSendTimeStamp = [NSString stringWithFormat:@"%ld",timeStamp];
    openCMD.RemoteImKey = pointIMKey;
    openCMD.LocalImKey = [EMClient sharedClient].currentUsername;
    openCMD.tag = @"command";
    openCMD.RemoteDeviceSerial = remoteSerial;
    openCMD.LocalDeviceSerial = [MXComUserDefault getUserLocalDeviceSerial];
    openCMD.CommandSequence = @"1";
    openCMD.OtherJSON = @"";
    
    return [self sendPointCMD:openCMD toPoint:pointIMKey];
}

- (BOOL)sendIdleStateCMDToGroup:(NSString *)groupID withRemoteSerial:(NSString *)remoteSerial andRemoteIMKey:(NSString *)pointIMKey
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    long timeStamp = (long)interval;
    
    MXEMCommandModel *openCMD = [[MXEMCommandModel alloc] init];
    openCMD.CommandAction = @"301";
    openCMD.CommandType = @"102";
    openCMD.CommandSendTimeStamp = [NSString stringWithFormat:@"%ld",timeStamp];
    openCMD.RemoteImKey = pointIMKey;
    openCMD.LocalImKey = [EMClient sharedClient].currentUsername;
    openCMD.tag = @"command";
    openCMD.RemoteDeviceSerial = remoteSerial;
    openCMD.LocalDeviceSerial = [MXComUserDefault getUserLocalDeviceSerial];
    openCMD.CommandSequence = @"1";
    openCMD.OtherJSON = @"";
    
    return [self sendGroupCMD:openCMD toGroup:groupID];
}

- (BOOL)sendCallAnswerCMDToGroup:(NSString *)groupID withRemoteSerial:(NSString *)remoteSerial andRemoteIMKey:(NSString *)pointIMKey
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    long timeStamp = (long)interval;
    
    MXEMCommandModel *openCMD = [[MXEMCommandModel alloc] init];
    openCMD.CommandAction = @"305";
    openCMD.CommandType = @"101";
    openCMD.CommandSendTimeStamp = [NSString stringWithFormat:@"%ld",timeStamp];
    openCMD.RemoteImKey = pointIMKey;
    openCMD.LocalImKey = [EMClient sharedClient].currentUsername;
    openCMD.tag = @"command";
    openCMD.RemoteDeviceSerial = remoteSerial;
    openCMD.LocalDeviceSerial = [MXComUserDefault getUserLocalDeviceSerial];
    openCMD.CommandSequence = @"1";
    openCMD.OtherJSON = @"";
    
    return [self sendGroupCMD:openCMD toGroup:groupID];
}

- (BOOL)sendCallHandupCMDToGroup:(NSString *)groupID withRemoteSerial:(NSString *)remoteSerial andRemoteIMKey:(NSString *)pointIMKey
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    long timeStamp = (long)interval;
    
    MXEMCommandModel *openCMD = [[MXEMCommandModel alloc] init];
    openCMD.CommandAction = @"302";
    openCMD.CommandType = @"101";
    openCMD.CommandSendTimeStamp = [NSString stringWithFormat:@"%ld",timeStamp];
    openCMD.RemoteImKey = pointIMKey;
    openCMD.LocalImKey = [EMClient sharedClient].currentUsername;
    openCMD.tag = @"command";
    openCMD.RemoteDeviceSerial = remoteSerial;
    openCMD.LocalDeviceSerial = [MXComUserDefault getUserLocalDeviceSerial];
    openCMD.CommandSequence = @"1";
    openCMD.OtherJSON = @"";
    
    return [self sendGroupCMD:openCMD toGroup:groupID];
}

- (BOOL)sendHandupCMDToPoint:(NSString *)pointIMKey withRemoteSerial:(NSString *)remoteSerial
{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    long timeStamp = (long)interval;
    
    MXEMCommandModel *openCMD = [[MXEMCommandModel alloc] init];
    openCMD.CommandAction = @"302";
    openCMD.CommandType = @"101";
    openCMD.CommandSendTimeStamp = [NSString stringWithFormat:@"%ld",timeStamp];
    openCMD.RemoteImKey = pointIMKey;
    openCMD.LocalImKey = [EMClient sharedClient].currentUsername;
    openCMD.tag = @"command";
    openCMD.RemoteDeviceSerial = remoteSerial;
    openCMD.LocalDeviceSerial = [MXComUserDefault getUserLocalDeviceSerial];
    openCMD.CommandSequence = @"1";
    openCMD.OtherJSON = @"";
    
    return [self sendPointCMD:openCMD toPoint:pointIMKey];
}

#pragma mark - 消息代理
- (void)didReceiveCmdMessages:(NSArray *)aCmdMessages
{
    EMMessage *message = aCmdMessages.firstObject;
    EMCmdMessageBody *body = (EMCmdMessageBody *)message.body;
    NSDictionary *responseDic = [MXJSONTool dictionaryWithJsonString:body.action];
    MXEMCommandModel *responseModel = [MXEMCommandModel mx_objectWithKeyValues:responseDic];
    // 操作类型
    NSInteger actionType = [responseModel.CommandAction integerValue];
    NSInteger commandType = [responseModel.CommandType integerValue];
    switch (actionType) {
            // 挂断
        case MXEMCammondActionType_Hangup:
        {
            // 不管是对方挂断还是自己挂断，先重置状态
            self.deviceState = MXDeviceState_Idle;
            if (commandType == MXEMCammondType_Request_Success) {
                
                NSLog(@"挂断成功");
            }else if(commandType == MXEMCammondType_Request) {
                [MXProgressHUD showError:@"对方已挂断" toView:nil];
                [self.incomingVC close];
                NSLog(@"请求发送挂断消息，对方已挂断");
            }
            NSLog(@"-----挂断");
        }
            break;
            // 开门
        case MXEMCammondActionType_Open:
        {
            self.openHasResponse = YES;
            if (commandType == MXEMCammondType_Request_Success) {
                [MXProgressHUD showSuccess:@"开门成功" toView:nil];
                [self writeOpenRecordToFile:YES];
                NSLog(@"开门成功");
            }else {
                [MXProgressHUD showError:@"开门失败" toView:nil];
                [self writeOpenRecordToFile:NO];
                NSLog(@"开门失败");
            }
            // 判断是否为钥匙包点击开门还是接听界面的开门
            if (self.keyBagVC) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.keyBagVC close];
                    self.deviceState = MXDeviceState_Idle;
                });
            }
            NSLog(@"-----开门");
        }
            break;
            // 监控
        case MXEMCammondActionType_Monitor:
        {
            self.monitorHasResponse = YES;
            // 门禁可以提供监控并将自动发送视频通话
            if (commandType == MXEMCammondType_Request_Success) {
                NSLog(@"发送监控成功");
            // 对方正忙，关闭连接页面，设置状态为闲置
            }else {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MXProgressHUD showError:@"对方正忙" toView:nil];
                    [self.incomingVC close];
                    self.deviceState = MXDeviceState_Idle;
                });
                NSLog(@"门禁没有响应");
            }
            NSLog(@"-----监控");
        }
            break;
            // 呼叫
        case MXEMCammondActionType_Answer:
        {
            // 判断回应的是否为当前设备
            if ([[MXComUserDefault getUserIMKey] isEqualToString:responseModel.RemoteImKey]) {
                if (commandType == MXEMCammondType_Request_Success) {
                    NSLog(@"接听成功");
                }else {
                    [MXProgressHUD showError:@"接听失败" toView:nil];
                    [self.incomingVC close];
                    self.deviceState = MXDeviceState_Idle;
                    NSLog(@"接听失败");
                }
            }else {
                [MXProgressHUD showError:@"已在其他设备处理" toView:nil];
                [self.incomingVC close];
                self.deviceState = MXDeviceState_Idle;
                NSLog(@"已在其他设备处理");
            }
            
            NSLog(@"-----接听");
        }
            break;
        default:
            break;
    }
    
    NSLog(@"收到的action是 -- %@",responseDic);
}

#pragma mark - 群代理
- (void)didJoinGroup:(EMGroup *)aGroup
             inviter:(NSString *)aInviter
             message:(NSString *)aMessage
{
    NSDictionary *responseDic = [MXJSONTool dictionaryWithJsonString:aMessage];
    MXEMCommandModel *responseModel = [MXEMCommandModel mx_objectWithKeyValues:responseDic];
    
    NSLog(@"%@----%@",aMessage,aGroup.groupId);
    if (self.deviceState == MXDeviceState_Idle) {
        MXIncomingVC *incomingVC = [[MXIncomingVC alloc] initWithIsCaller:NO andKeyName:responseModel.LocalDeviceSerial];
        incomingVC.remoteIMKey = responseModel.LocalImKey;
        incomingVC.remoteSerial = responseModel.LocalDeviceSerial;
        incomingVC.groupId = aGroup.groupId;
        self.incomingVC = incomingVC;
        self.deviceState = MXDeviceState_Ringing;
        [MXApplicationAccessor.keyWindow.rootViewController presentViewController:incomingVC animated:YES completion:nil];
        
        [self sendIdleStateCMDToGroup:aGroup.groupId withRemoteSerial:responseModel.LocalDeviceSerial andRemoteIMKey:responseModel.LocalImKey];
    }
    // 不在线或者未打开app时发送本地通知
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) {
        [self sendCallingLocalNotification];
    }
}

#pragma mark - 视频通话
- (void)didReceiveCallIncoming:(EMCallSession *)aSession
{
    if(_callSession && _callSession.status != EMCallSessionStatusDisconnected){
        [[EMClient sharedClient].callManager endCall:aSession.sessionId reason:EMCallEndReasonBusy];
    }
    
    if ([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive) {
        [[EMClient sharedClient].callManager endCall:aSession.sessionId reason:EMCallEndReasonFailed];
    }
    
    _callSession = aSession;
    if(_callSession) {
        // 判断获得session之前是否窗口已经被关闭
        if (self.incomingVC) {
            self.incomingVC.callSession = aSession;
            // 自动接通
            [self acceptSession:aSession];
        
        }else {
            // 视频监控上一次挂断操作延时获得的session
            if (self.deviceState == MXDeviceState_Busy) {
                [[EMClient sharedClient].callManager endCall:_callSession.sessionId reason:EMCallEndReasonHangup];
                self.deviceState = MXDeviceState_Idle;
            // 机器主动呼叫获得的session
            }else if (self.deviceState == MXDeviceState_Ringing){
                [self acceptSession:aSession];
            }
        }
    }
}

- (void)didReceiveCallConnected:(EMCallSession *)aSession
{
    if ([aSession.sessionId isEqualToString:_callSession.sessionId]) {
        self.deviceState = MXDeviceState_Connected;
    }
}

- (void)didReceiveCallAccepted:(EMCallSession *)aSession
{
    // 视频信号接通后调用此方法，此时显示视频窗口
    if ([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive) {
        [[EMClient sharedClient].callManager endCall:aSession.sessionId reason:EMCallEndReasonFailed];
    }
    
    if ([aSession.sessionId isEqualToString:_callSession.sessionId]) {
        [[MXEMClientTool shareTool].incomingVC startTiming];
    }
}

- (void)didReceiveCallTerminated:(EMCallSession *)aSession
                          reason:(EMCallEndReason)aReason
                           error:(EMError *)aError
{
    if ([aSession.sessionId isEqualToString:_callSession.sessionId]) {
        [self.incomingVC close];
        // 重置状态
        self.callSession = nil;
        self.incomingVC = nil;
        self.monitorVC = nil;
        self.deviceState = MXDeviceState_Idle;
        self.openHasResponse = NO;
        self.monitorHasResponse = NO;

        if (aReason != EMCallEndReasonHangup) {
            NSString *reasonStr = @"";
            switch (aReason) {
                case EMCallEndReasonNoResponse:
                {
                    reasonStr = @"NO response";
                }
                    break;
                case EMCallEndReasonDecline:
                {
                    reasonStr = @"Reject the call";
                }
                    break;
                case EMCallEndReasonBusy:
                {
                    reasonStr = @"In the call...";
                }
                    break;
                case EMCallEndReasonFailed:
                {
                    reasonStr = @"Connect failed";
                }
                    break;
                default:
                    break;
            }
            
            if (aError) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:aError.errorDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
            else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:reasonStr delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }
    }
}

- (void)didReceiveCallNetworkChanged:(EMCallSession *)aSession status:(EMCallNetworkStatus)aStatus
{
    if ([aSession.sessionId isEqualToString:_callSession.sessionId]) {
        // 设置网络状态
    }
}

#pragma mark - 内部方法
- (void)acceptSession:(EMCallSession *)callSession
{
    if (callSession) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            EMError *error = [[EMClient sharedClient].callManager answerIncomingCall:callSession.sessionId];
            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (error.code == EMErrorNetworkUnavailable) {
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"network.disconnection", @"Network disconnection") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
                        [alertView show];
                    }
                    else{
                        //                        [self hangupCallWithReason:EMCallEndReasonFailed];
                    }
                });
            }
        });
    }
}

- (void)writeOpenRecordToFile:(BOOL)success
{
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path=[docPath stringByAppendingPathComponent:@"open.record"];
    NSLog(@"path==%@",path);
    
    NSMutableArray *recordArray = nil;
    if ([NSKeyedUnarchiver unarchiveObjectWithFile:path] && [[NSKeyedUnarchiver unarchiveObjectWithFile:path] isKindOfClass:[NSMutableArray class]]) {
        recordArray = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }else {
        recordArray = [NSMutableArray array];
    }
    
    MXOpenRecordModel *model = [[MXOpenRecordModel alloc] init];
    model.time = [self getTime];
    model.result = success ? @"开门成功" : @"开门失败";
    [recordArray addObject:model];
    
    [NSKeyedArchiver archiveRootObject:recordArray toFile:path];
}

- (NSString *)getTime
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    return dateString;
}

- (void)sendCallingLocalNotification
{
    UILocalNotification *localNoti = [[UILocalNotification alloc] init];
    
    localNoti.fireDate = [NSDate dateWithTimeIntervalSinceNow:0];
    localNoti.timeZone = [NSTimeZone defaultTimeZone];
    localNoti.alertBody = @"主机请求视频通话...";
    localNoti.soundName = @"Ladder.caf";
    localNoti.applicationIconBadgeNumber = 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNoti];
}
@end
