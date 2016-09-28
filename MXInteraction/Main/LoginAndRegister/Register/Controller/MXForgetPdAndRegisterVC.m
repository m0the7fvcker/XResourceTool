//
//  MXForgetPdAndRegisterVC.m
//  MXInteraction
//
//  Created by maRk'sTheme on 16/8/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXForgetPdAndRegisterVC.h"
#import "MXHomeViewController.h"

#import "MXComUserDefault.h"
#import "MXHttpRequest+LoginAndRegister.h"

@interface MXForgetPdAndRegisterVC ()

@property (nonatomic, assign) BOOL hasSentMesg;
@property (nonatomic, strong) NSTimer *countDownTimer;
@property (nonatomic, assign) NSInteger countDownSecond;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation MXForgetPdAndRegisterVC

#pragma mark - 懒加载
- (NSTimer *)countDownTimer
{
    if (!_countDownTimer) {
        _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_countDownTimer forMode:NSRunLoopCommonModes];
    }
    return _countDownTimer;
}

#pragma mark - 控制器方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
    [self addTapGesture];
    [self startCountdown];
    [self getVerifyCode];
}

#pragma mark - 初始化方法
- (void)initUI
{
    self.codeTextField.layer.cornerRadius = 5;
    self.codeTextField.layer.borderWidth = 1;
    self.codeTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.phoneTextField.layer.cornerRadius = 5;
    self.phoneTextField.layer.borderWidth = 1;
    self.phoneTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.countDownLabel.layer.cornerRadius = 5;
    
    self.registerButton.layer.cornerRadius = 5;
    self.registerButton.backgroundColor = [UIColor mx_colorWithHexString:@"19b0e9"];
    [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)addTapGesture
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    tapGesture.enabled = YES;
    [tapGesture addTarget:self action:@selector(startCountdown)];
    self.tapGesture = tapGesture;
    [self.countDownLabel addGestureRecognizer:tapGesture];
}

#pragma mark - 内部方法
- (void)getVerifyCode
{
    // 获取验证码
    [MXHttpRequest GetVerifyCodeWithPhoneNumber:self.phoneNumber success:^(NSInteger result) {
        if (result == 000000) {
            NSLog(@"发送验证码成功");
        }else {
            NSLog(@"发送验证码失败");
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"发送验证码失败");
    }];
}

- (void)startCountdown
{
    if (!self.hasSentMesg) {
        self.countDownLabel.backgroundColor = [UIColor lightGrayColor];
        self.hasSentMesg = YES;
        self.countDownSecond = 5;
        [self.countDownTimer fire];
    }
}

- (IBAction)goNext:(UIButton *)sender
{
    // 修改登录状态
//    [MXComUserDefault setHasLogin:YES];
    NSString *code = self.codeTextField.text;
    NSString *password = self.phoneTextField.text;
    [MXHttpRequest RegisterNewUserWithPhoneNumber:self.phoneNumber vierifyCode:code password:password success:^(NSInteger result) {
        if (result == 000000) {
            NSLog(@"注册成功");
//            MXHomeViewController *homeVC = [[MXHomeViewController alloc] init];
//            [self.navigationController pushViewController:homeVC animated:YES];
            // 修改登录状态
            [MXComUserDefault setHasLogin:YES];
            // 保存账户到本地
            [MXComUserDefault saveUserAccount:self.phoneNumber];
            // 保存密码到本地
            [MXComUserDefault saveUserPassword:password withAccount:self.phoneNumber];
            [MXNotificationCenterAccessor postNotificationName:MXNoti_Launch_ChangeVC object:nil];
        }else {
            NSLog(@"注册失败");
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"注册失败");
    }];
}

- (void)countDown
{
    if (self.countDownSecond == 0) {
        [self.countDownTimer invalidate];
//        self.countDownTimer = nil;
        self.hasSentMesg = NO;
        self.countDownLabel.backgroundColor = [UIColor clearColor];
        self.countDownLabel.text = @"重新获取";
        self.tapGesture.enabled = YES;
        return;
    }
    self.countDownSecond --;
    self.countDownLabel.text = [NSString stringWithFormat:@"%ld秒后重发",(long)self.countDownSecond];
}

@end
