//
//  MXLoginViewController.m
//  MXInteraction
//
//  Created by maRk on 16/8/22.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXLoginViewController.h"
#import "MXEnterPhoneViewController.h"
#import "MXHomeViewController.h"

#import "MXComUserDefault.h"
#import "MXHttpRequest+LoginAndRegister.h"

@interface MXLoginViewController ()<UITextFieldDelegate>

@end

@implementation MXLoginViewController

#pragma mark - 控制器方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - 初始化方法
- (void)initUI
{
    self.accountTF.layer.cornerRadius = 5;
    self.accountTF.layer.borderWidth = 1;
    self.accountTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.passwordTF.layer.cornerRadius = 5;
    self.passwordTF.layer.borderWidth = 1;
    self.passwordTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.backgroundColor = [UIColor mx_colorWithHexString:@"19b0e9"];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

#pragma mark - 内部方法
- (IBAction)loginClick:(UIButton *)sender
{
    NSString *phoneNumber = self.accountTF.text;
    NSString *password = self.passwordTF.text;
    
    [MXHttpRequest LoginWithPhoneNumber:phoneNumber password:password appVersion:@"1-1" success:^(NSDictionary *data) {
        NSLog(@"%@",data);
        NSString *status = data[@"status"];
        if ([status isEqualToString:@"000000"]) {
            NSLog(@"登录成功");
//            MXHomeViewController *homeVC = [[MXHomeViewController alloc] init];
//            [self.navigationController pushViewController:homeVC animated:YES];
            // 修改登录状态
            [MXComUserDefault setHasLogin:YES];
            // 保存账户到本地
            [MXComUserDefault saveUserAccount:phoneNumber];
            // 保存密码到本地
            [MXComUserDefault saveUserPassword:password withAccount:phoneNumber];
            [MXNotificationCenterAccessor postNotificationName:MXNoti_Launch_ChangeVC object:nil userInfo:@{@"data" : data}];
        }else {
            NSLog(@"登录失败");
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"登录失败");
    }];
   
}

- (IBAction)forgetPwClick:(UIButton *)sender
{
    MXEnterPhoneViewController *enterPhoneVC = [[MXEnterPhoneViewController alloc] init];
    [self.navigationController pushViewController:enterPhoneVC animated:YES];
}

@end
