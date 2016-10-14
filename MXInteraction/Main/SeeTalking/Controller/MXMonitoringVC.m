//
//  MXMonitoringVC.m
//  MXInteraction
//
//  Created by maRk on 16/10/11.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXMonitoringVC.h"
#import <AVFoundation/AVFoundation.h>

@interface MXMonitoringVC ()

@property (nonatomic, strong) EMCallSession *callSession;
@property (nonatomic, weak) UIImageView *bgView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *countdownLabel;
@property (nonatomic, weak) UIButton *speakerBtn;
@property (nonatomic, weak) UIButton *unlockBtn;
@property (nonatomic, weak) UIButton *rejectBtn;

@end

@implementation MXMonitoringVC

- (instancetype)initWithSessicon:(EMCallSession *)callSession
{
    if (self = [super init]) {
        self.callSession = callSession;
        [self initUI];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI
{
//    self.view.backgroundColor = [UIColor yellowColor];
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
    
    self.callSession.remoteVideoView = [[EMCallRemoteView alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, 300)];
    self.callSession.remoteVideoView.backgroundColor = [UIColor redColor];
    self.callSession.remoteVideoView.center = self.view.center;
    [self.view addSubview:self.callSession.remoteVideoView];
    
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
    unlockBtn.centerX = MXScreen_Width * 5 / 6;
    [unlockBtn setBackgroundImage:[UIImage imageNamed:@"seeTalking_unlock"] forState:UIControlStateNormal];
    [unlockBtn addTarget:self action:@selector(unlockClick) forControlEvents:UIControlEventTouchUpInside];
    self.unlockBtn = unlockBtn;
    [self.view addSubview:unlockBtn];
}

- (void)rejectClick
{
    if (self.callSession) {
        [[EMClient sharedClient].callManager endCall:_callSession.sessionId reason:EMCallEndReasonDecline];
    }
    // 设置状态为闲置状态
    [MXEMClientTool shareTool].deviceState = MXDeviceState_Idle;
    [[MXEMClientTool shareTool] sendHandupCMDToPoint:self.remoteIMKey withRemoteSerial:self.remoteSerial];
    [self close];
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

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
