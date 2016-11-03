//
//  MXLaunchADViewController.m
//  MXInteraction
//
//  Created by maRk on 16/8/22.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXLaunchADViewController.h"

@interface MXLaunchADViewController ()

@property (nonatomic, weak  ) UIImageView            *adView;
@property (nonatomic, strong) NSString               *adImageUrl;
@property (nonatomic, assign) NSInteger              showSeconds;
@property (nonatomic, strong) NSTimer                *coundDownTimer;
@property (nonatomic, strong) UILabel                *secondLb;
@property (nonatomic, strong) UIButton               *jumpBtn;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) NSString               *jumpUrl;
@property (nonatomic, strong) NSString               *jumpTitle;
@property (nonatomic, strong) UIImage                *adImage;
@property (nonatomic, assign) BOOL                   canJump;

@end

@implementation MXLaunchADViewController

#pragma mark - 懒加载
- (NSTimer *)coundDownTimer
{
    if (!_coundDownTimer) {
        _coundDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(ADCountdown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_coundDownTimer forMode:NSRunLoopCommonModes];
    }
    return _coundDownTimer;
}

#pragma mark - 控制器方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.showSeconds > 0) {
        [self.coundDownTimer fire];
    }else {
        [self jumpToHome];
    }
}

#pragma mark - 初始化方法
- (void)initData
{
    self.showSeconds = 3;
}

- (void)initUI
{
    self.view.backgroundColor        = [UIColor mx_colorWithHexString:@"f5f5f5"];
    UIImageView *adView              = [[UIImageView alloc] initWithFrame:self.view.bounds];
    adView.image                     = [self getLocalAdImageFromLocal];
    adView.userInteractionEnabled    = YES;
    self.adView                      = adView;
    [self.view addSubview:adView];
    
    // 简单布局，就不用约束了
    UIButton *jumpBtn          = [[UIButton alloc] init];
    jumpBtn.frame              = CGRectMake(MXScreen_Width - 25 - 64, 25, 64, 25);
    jumpBtn.layer.cornerRadius = 4.5;
    jumpBtn.alpha              = 0.5;
    jumpBtn.hidden             = self.showSeconds <= 0;
    jumpBtn.backgroundColor    = [UIColor mx_colorWithHexString:@"ffffff"];
    jumpBtn.titleLabel.font    = [UIFont systemFontOfSize:15.5];
    [jumpBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [jumpBtn setTitleColor:[UIColor mx_colorWithHexString:@"999999"] forState:UIControlStateNormal];
    [jumpBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [jumpBtn addTarget:self action:@selector(jumpToHome) forControlEvents:UIControlEventTouchUpInside];
    [jumpBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    self.jumpBtn               = jumpBtn;
    
    UILabel *countdownLb       = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 10, 25)];
    countdownLb.font           = [UIFont systemFontOfSize:16];
    countdownLb.textColor      = [UIColor mx_colorWithHexString:@"999999"];
    self.secondLb              = countdownLb;
    
    [jumpBtn addSubview:countdownLb];
    
    [self.view addSubview:jumpBtn];
}

#pragma mark - 内部方法
- (void)jumpToHome
{
    [MXNotificationCenterAccessor postNotificationName:MXNoti_Launch_ChangeVC object:nil];
    // 点击跳转后不用再调jumpBtnClick防止再刷新一次
    self.showSeconds = -2;
}

- (void)ADCountdown
{
    self.secondLb.text = [NSString stringWithFormat:@"%ld",(long)self.showSeconds];
    // 正常倒计时结束
    if (self.showSeconds == 0) {
        [self.coundDownTimer invalidate];
        self.coundDownTimer = nil;
        [self jumpToHome];
        // 点击跳过
    } else if (self.showSeconds == -2) {
        [self.coundDownTimer invalidate];
        self.coundDownTimer = nil;
    }
    
    self.showSeconds --;
}

- (UIImage *)getLocalAdImageFromLocal
{
    NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    UIImage *adImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/adImage",documentsDirectoryPath]];
    
    if (adImage == nil) {
        return [UIImage imageNamed:@"ad.png"];
        return nil;
    }
    
    return adImage;
}

@end
