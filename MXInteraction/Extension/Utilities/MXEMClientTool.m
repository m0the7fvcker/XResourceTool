//
//  MXEMClientTool.m
//  MXInteraction
//
//  Created by maRk on 16/10/11.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXEMClientTool.h"
#import "MXMonitoringVC.h"
#import "MXIncomingVC.h"

#import "MXAppDelegate.h"

#import "MXJSONTool.h"

@interface MXEMClientTool()<EMChatManagerDelegate, EMCallManagerDelegate, EMGroupManagerDelegate>

@property (nonatomic, strong) EMCallSession *callSession;
@property (nonatomic, strong) MXMonitoringVC *monitorVC;
@property (nonatomic, strong) MXIncomingVC *incomingVC;

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
            if (commandType == MXEMCammondType_Request_Success) {
                NSLog(@"挂断成功");
            }else if(commandType == MXEMCammondType_Request) {
                NSLog(@"请求发送挂断消息");
            }
            NSLog(@"-----挂断");
        }
            break;
            // 开门
        case MXEMCammondActionType_Open:
        {
            if (commandType == MXEMCammondType_Request_Success) {
                [MXProgressHUD showSuccess:@"开门成功" toView:nil];
                NSLog(@"开门成功");
            }else if(commandType == MXEMCammondType_Request) {
                NSLog(@"请求发送开门消息");
            }else {
                [MXProgressHUD showError:@"开门失败" toView:nil];
            }
            NSLog(@"-----开门");
        }
            break;
            // 监控
        case MXEMCammondActionType_Monitor:
        {
            if (commandType == MXEMCammondType_Request_Success) {
                NSLog(@"发送监控成功");
                self.incomingVC = [[MXIncomingVC alloc] initWithIsCaller:YES];
                self.incomingVC.remoteIMKey = responseModel.LocalImKey;
                self.incomingVC.remoteSerial = responseModel.LocalDeviceSerial;
                // 修改状态为响铃状态
                self.deviceState = MXDeviceState_Connecting;
                [MXAppDelegateAccessor.window.rootViewController presentViewController:self.incomingVC animated:YES completion:nil];
            }else if(commandType == MXEMCammondType_Request) {
                NSLog(@"请求发送监控消息");
            }else {
                NSLog(@"请求发送监控对方正忙");
            }
            NSLog(@"-----监控");
        }
            break;
            // 呼叫
        case MXEMCammondActionType_Answer:
        {
            if (commandType == MXEMCammondType_Request_Success) {
                NSLog(@"接听成功");
            }else if(commandType == MXEMCammondType_Request) {
                NSLog(@"请求发送接听消息");
            }
            NSLog(@"-----接听");
        }
            break;
        default:
            break;
    }
    
    NSLog(@"收到的action是 -- %@",responseDic);
}

#pragma mark - 加群代理
- (void)didJoinGroup:(EMGroup *)aGroup
             inviter:(NSString *)aInviter
             message:(NSString *)aMessage
{
    NSDictionary *responseDic = [MXJSONTool dictionaryWithJsonString:aMessage];
    MXEMCommandModel *responseModel = [MXEMCommandModel mx_objectWithKeyValues:responseDic];
    
    NSLog(@"%@----%@",aMessage,aGroup.groupId);
    [self sendIdleStateCMDToGroup:aGroup.groupId withRemoteSerial:responseModel.LocalDeviceSerial andRemoteIMKey:responseModel.LocalDeviceSerial];
    [self sendCallAnswerCMDToGroup:aGroup.groupId withRemoteSerial:responseModel.LocalDeviceSerial andRemoteIMKey:responseModel.LocalImKey];
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
        // 主动监控来电
        if (self.incomingVC) {
            self.incomingVC.callSession = aSession;
            // 自动接通
            [self acceptSession:aSession];
        // 被动机器呼叫
        }else {
            MXIncomingVC *incomeVC = [[MXIncomingVC alloc] initWithSessicon:aSession andIsCaller:NO];
            self.incomingVC = incomeVC;
            [MXAppDelegateAccessor.window.rootViewController presentViewController:incomeVC animated:NO completion:nil];
        }
    }
}

- (void)didReceiveCallConnected:(EMCallSession *)aSession
{
    if ([aSession.sessionId isEqualToString:_callSession.sessionId]) {
        
    }
}

- (void)didReceiveCallAccepted:(EMCallSession *)aSession
{
    // 视频信号接通后调用此方法，此时显示视频窗口
    if ([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive) {
        [[EMClient sharedClient].callManager endCall:aSession.sessionId reason:EMCallEndReasonFailed];
    }
    
    if ([aSession.sessionId isEqualToString:_callSession.sessionId]) {
        if (self.incomingVC) {
            
            MXMonitoringVC *monitorVC = [[MXMonitoringVC alloc] initWithSessicon:aSession andIsCaller:NO];
            monitorVC.remoteIMKey = self.incomingVC.remoteIMKey;
            monitorVC.remoteSerial = self.incomingVC.remoteSerial;
            [self.incomingVC close];
            [MXAppDelegateAccessor.window.rootViewController presentViewController:monitorVC animated:NO completion:nil];
            
        }
    }
}

- (void)didReceiveCallTerminated:(EMCallSession *)aSession
                          reason:(EMCallEndReason)aReason
                           error:(EMError *)aError
{
    if ([aSession.sessionId isEqualToString:_callSession.sessionId]) {
        _callSession = nil;
        _incomingVC = nil;

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
//        [_callController setNetwork:aStatus];
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

@end
