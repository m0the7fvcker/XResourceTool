//
//  MXIncomingVC.m
//  MXInteraction
//
//  Created by maRk on 16/10/11.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXIncomingVC.h"
#import "EMCallSession.h"

@interface MXIncomingVC ()

@property (nonatomic, weak) UIImageView *bgView;
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
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 100, 40)];
    titleLabel.text = @"正在监视01号主机";
    self.titleLabel = titleLabel;
    [self.view addSubview:titleLabel];
    
    UILabel *countdownLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 20)];
    countdownLabel.text = @"10:00";
    self.countdownLabel = countdownLabel;
    [self.view addSubview:countdownLabel];
    
    self.callSession.remoteVideoView = [[EMCallRemoteView alloc] initWithFrame:CGRectMake(50 , 100, 200, 200)];
    self.callSession.remoteVideoView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.callSession.remoteVideoView];
    
    UIButton *rejectBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 50, 50)];
    [rejectBtn setTitle:@"拒绝" forState:UIControlStateNormal];
    rejectBtn.backgroundColor = [UIColor redColor];
    [rejectBtn addTarget:self action:@selector(rejectClick) forControlEvents:UIControlEventTouchUpInside];
    self.rejectBtn = rejectBtn;
    [self.view addSubview:rejectBtn];
    
    UIButton *speakerBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 300, 50, 50)];
    [speakerBtn setBackgroundImage:[UIImage imageNamed:@"seeTalking_speaker"] forState:UIControlStateNormal];
    speakerBtn.backgroundColor = [UIColor redColor];
    [speakerBtn addTarget:self action:@selector(speakerClick) forControlEvents:UIControlEventTouchUpInside];
    self.speakerBtn = speakerBtn;
    [self.view addSubview:speakerBtn];
    
    UIButton *unlockBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 300, 50, 50)];
    [unlockBtn setTitle:@"开门" forState:UIControlStateNormal];
    unlockBtn.backgroundColor = [UIColor redColor];
    unlockBtn.hidden = !self.isCaller;
    [unlockBtn addTarget:self action:@selector(speakerClick) forControlEvents:UIControlEventTouchUpInside];
    self.unlockBtn = unlockBtn;
    [self.view addSubview:unlockBtn];
    
    UIButton *acceptBtn = [[UIButton alloc] initWithFrame:CGRectMake(300, 300, 50, 50)];
    [acceptBtn setTitle:@"接受" forState:UIControlStateNormal];
    acceptBtn.backgroundColor = [UIColor greenColor];
    [acceptBtn addTarget:self action:@selector(acceptClick) forControlEvents:UIControlEventTouchUpInside];
    self.acceptBtn = acceptBtn;
    [self.view addSubview:acceptBtn];
    

    
}

- (void)speakerClick
{
    
}

- (void)unlockClick
{
    
}

- (void)acceptClick
{
    if (self.callSession) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            EMError *error = [[EMClient sharedClient].callManager answerIncomingCall:self.callSession.sessionId];
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

- (void)rejectClick
{
    if (self.callSession) {
        [[EMClient sharedClient].callManager endCall:_callSession.sessionId reason:EMCallEndReasonHangup];
    }
    // 设置状态为闲置状态
    [MXEMClientTool shareTool].deviceState = MXDeviceState_Idle;
    [[MXEMClientTool shareTool] sendHandupCMDToPoint:self.remoteIMKey withRemoteSerial:self.remoteSerial];
    [self close];
}

- (void)close
{
    [self removeFromParentViewController];
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
