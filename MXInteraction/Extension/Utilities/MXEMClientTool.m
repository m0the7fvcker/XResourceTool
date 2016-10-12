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

- (BOOL)sendCMD:(NSDictionary *)cmd to:(NSString *)to
{
//    NSDictionary *cmdDic = @{@"CommandSendTimeStamp" : @"1476018140894",
//                             @"CommandAction" : @"303",
//                             @"RemoteImKey" : @"ef131bc92b73ebee7f12d71611ff6898"
//                             };
//    NSString *cmdMg = [MXJSONTool dictionaryToJson:cmd];
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    
    EMCmdMessageBody *body = [[EMCmdMessageBody alloc] initWithAction:@"{\"CommandSendTimeStamp\":\"1476265531808\",\"CommandAction\":\"303\",\"RemoteImKey\":\"ef131bc92b73ebee4e0b4d5bed760661\",\"LocalImKey\":\"4c5719f1dd3b2258fc922553abc9ce7f\",\"CommandType\":\"101\",\"tag\":\"command\",\"RemoteDeviceSerial\":\"02010101000001\",\"CommandSequence\":\"26\",\"LocalDeviceSerial\":\"000101010101\",\"OtherJSON\":\"\"}"];
    
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    EMMessage *message = [[EMMessage alloc] initWithConversationID:to from:from to:to body:body ext:nil];
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

- (BOOL)sendCallTo:(NSString *)to
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

#pragma mark - 消息代理
- (void)didReceiveMessages:(NSArray *)aMessages
{
    
}

- (void)didReceiveCmdMessages:(NSArray *)aCmdMessages
{
    
}

#pragma mark - 加群代理
- (void)didJoinGroup:(EMGroup *)aGroup
             inviter:(NSString *)aInviter
             message:(NSString *)aMessage
{
    NSLog(@"%@",aMessage);
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
    if(_callSession){
        MXIncomingVC *incomingVC = [[MXIncomingVC alloc] initWithSessicon:aSession andIsCaller:YES];
        self.incomingVC = incomingVC;
        [MXAppDelegateAccessor.window.rootViewController presentViewController:incomingVC animated:YES completion:nil];
    }
}

- (void)didReceiveCallConnected:(EMCallSession *)aSession
{
    if ([aSession.sessionId isEqualToString:_callSession.sessionId]) {

    }
}

- (void)didReceiveCallAccepted:(EMCallSession *)aSession
{
    if ([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive) {
        [[EMClient sharedClient].callManager endCall:aSession.sessionId reason:EMCallEndReasonFailed];
    }
    
    if ([aSession.sessionId isEqualToString:_callSession.sessionId]) {

    }
}

- (void)didReceiveCallTerminated:(EMCallSession *)aSession
                          reason:(EMCallEndReason)aReason
                           error:(EMError *)aError
{
    if ([aSession.sessionId isEqualToString:_callSession.sessionId]) {
        //        [self _stopCallTimer];
        
        _callSession = nil;
        
        [self.incomingVC close];
        //        _callController = nil;
        
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
@end
