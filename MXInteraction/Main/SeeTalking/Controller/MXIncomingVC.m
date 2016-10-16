//
//  MXIncomingVC.m
//  MXInteraction
//
//  Created by maRk on 16/10/11.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXIncomingVC.h"
#import "EMCallSession.h"
#import <AVFoundation/AVFoundation.h>

@interface MXIncomingVC ()

@property (nonatomic, weak) UIImageView *bgView;
@property (nonatomic, weak) UIImageView *userIconView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *countdownLabel;
@property (nonatomic, weak) UIButton *acceptBtn;
@property (nonatomic, weak) UIButton *unlockBtn;
@property (nonatomic, weak) UIButton *rejectBtn;
@property (nonatomic, weak) UIButton *speakerBtn;

@end

@implementation MXIncomingVC

- (instancetype)initWithSessicon:(EMCallSession *)callSession andIsCaller:(BOOL)isCaller
{
    if (self = [super init]) {
        self.callSession = callSession;
        self.isCaller = isCaller;
        [self initUI];
    }
    return self;
}

- (instancetype)initWithIsCaller:(BOOL)isCaller
{
    if (self = [super init]) {
        self.isCaller = isCaller;
        [self initUI];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgView.image = [UIImage imageNamed:@"calling_bg.png"];
    self.bgView = bgView;
    [self.view addSubview:bgView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 200, 40)];
    titleLabel.centerX = self.view.centerX;
    titleLabel.text = @"正在监视01号主机";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel = titleLabel;
    [self.view addSubview:titleLabel];
    
    UILabel *countdownLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 100, 20)];
    countdownLabel.centerX = self.view.centerX;
    countdownLabel.textAlignment = NSTextAlignmentCenter;
    countdownLabel.textColor = [UIColor whiteColor];
    countdownLabel.font = [UIFont systemFontOfSize:14];
    countdownLabel.text = @"正在连接...";
    self.countdownLabel = countdownLabel;
    [self.view addSubview:countdownLabel];
    
    UIImageView *userIconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    userIconView.image = [UIImage imageNamed:@"icon_personal_user"];
    userIconView.center = self.view.center;
    self.userIconView = userIconView;
    [self.view addSubview:userIconView];
    
    UIButton *rejectBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 , MXScreen_Height - 150, 60, 60)];
    rejectBtn.centerX = MXScreen_Width / 6;
    [rejectBtn setBackgroundImage:[UIImage imageNamed:@"seeTalking_reject"] forState:UIControlStateNormal];
    [rejectBtn addTarget:self action:@selector(rejectClick) forControlEvents:UIControlEventTouchUpInside];
    self.rejectBtn = rejectBtn;
    [self.view addSubview:rejectBtn];
    
    UIButton *speakerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, MXScreen_Height - 150, 60, 60)];
    speakerBtn.centerX = MXScreen_Width / 2;
    [speakerBtn setBackgroundImage:[UIImage imageNamed:@"seeTalking_speaker"] forState:UIControlStateNormal];
    [speakerBtn addTarget:self action:@selector(speakerClick) forControlEvents:UIControlEventTouchUpInside];
    self.speakerBtn = speakerBtn;
    [self.view addSubview:speakerBtn];
    
    UIButton *unlockBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, MXScreen_Height - 150, 60, 60)];
    [unlockBtn setBackgroundImage:[UIImage imageNamed:@"seeTalking_unlock"] forState:UIControlStateNormal];
    [unlockBtn addTarget:self action:@selector(unlockClick) forControlEvents:UIControlEventTouchUpInside];
    self.unlockBtn = unlockBtn;
    [self.view addSubview:unlockBtn];
    if (!self.isCaller) {
        unlockBtn.centerX = MXScreen_Width / 2;
    }else {
        unlockBtn.centerX = MXScreen_Width * 5 / 6;
    }
    
    UIButton *acceptBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, MXScreen_Height - 150, 60, 60)];
    acceptBtn.centerX = MXScreen_Width * 5 / 6;
    [acceptBtn setBackgroundImage:[UIImage imageNamed:@"seeTalking_accept"] forState:UIControlStateNormal];
    acceptBtn.hidden = self.isCaller;
    [acceptBtn addTarget:self action:@selector(acceptClick) forControlEvents:UIControlEventTouchUpInside];
    self.acceptBtn = acceptBtn;
    [self.view addSubview:acceptBtn];
    
}

- (void)speakerClick
{
    if ([[[AVAudioSession sharedInstance] category] isEqualToString:AVAudioSessionCategoryPlayback])
    {
        //切换为听筒播放
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        
    }else {
        //切换为扬声器播放
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
}

- (void)unlockClick
{
    // 开门
    [[MXEMClientTool shareTool] sendOpenRequestCMDToPoint:self.remoteIMKey withRemoteSerial:self.remoteSerial];
    [MXEMClientTool shareTool].openHasResponse = NO;
    [MXEMClientTool shareTool].deviceState = MXDeviceState_Busy;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (![MXEMClientTool shareTool].openHasResponse) {
            [MXProgressHUD showError:@"对方不在线" toView:nil];
            [MXEMClientTool shareTool].deviceState = MXDeviceState_Idle;
        }
    });
}

- (void)acceptClick
{
    [[MXEMClientTool shareTool] sendCallAnswerCMDToGroup:self.groupId withRemoteSerial:self.remoteSerial andRemoteIMKey:self.remoteIMKey];
    __block CGRect acceptFrame = self.acceptBtn.frame;
    // 修改状态为已连接，因为门禁此时已经开始自动呼叫手机
    [MXEMClientTool shareTool].deviceState = MXDeviceState_Connected;
    [UIView animateWithDuration:0.25 animations:^{
        self.unlockBtn.frame = acceptFrame;
        self.acceptBtn.hidden = YES;
    } completion:nil];
}

- (void)rejectClick
{
    if (self.callSession) {
        [[EMClient sharedClient].callManager endCall:_callSession.sessionId reason:EMCallEndReasonHangup];
    }
    // 为主动监视
    if (self.isCaller) {
        [[MXEMClientTool shareTool] sendHandupCMDToPoint:self.remoteIMKey withRemoteSerial:self.remoteSerial];
    // 为主机来电
    }else {
        // 响铃状态就挂断
        if ([MXEMClientTool shareTool].deviceState == MXDeviceState_Ringing) {
            [[MXEMClientTool shareTool] sendCallHandupCMDToGroup:self.groupId withRemoteSerial:self.remoteSerial andRemoteIMKey:self.remoteIMKey];
        // 接通后挂断
        }else {
            [[MXEMClientTool shareTool] sendHandupCMDToPoint:self.remoteIMKey withRemoteSerial:self.remoteSerial];
        }
        // 主动修改状态
        [MXEMClientTool shareTool].deviceState = MXDeviceState_Idle;
    }
    [self close];
}

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [MXEMClientTool shareTool].incomingVC = nil;
}

- (void)setCallSession:(EMCallSession *)callSession
{
    _callSession = callSession;
    _callSession.remoteVideoView.contentMode = UIViewContentModeScaleToFill;
    _callSession.remoteVideoView = [[EMCallRemoteView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, 300)];
    _callSession.remoteVideoView.backgroundColor = [UIColor redColor];
    _callSession.remoteVideoView.center = self.view.center;
    [self.view addSubview:self.callSession.remoteVideoView];
    
}
@end
