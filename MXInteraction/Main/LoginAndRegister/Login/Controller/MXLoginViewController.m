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
    BOOL phoneNumberLegal =  [self judgePhoneNumber:phoneNumber];
    NSString *password = self.passwordTF.text;
    BOOL passwordLegal = [self judgePassword:password];
    
    // 判断账户密码是否合法有效
    if (!(phoneNumberLegal && passwordLegal)) return;
    
    [MXProgressHUD showMessage:@"正在登陆" toView:self.view];
    MXWeakSelf;
    [MXHttpRequest LoginWithPhoneNumber:phoneNumber password:password appVersion:@"1-1" success:^(MXBaseDataModel * _Nonnull responseModel) {
        NSInteger status = responseModel.status;
        [MXProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if (status == MXRequestCode_Success) {
            NSLog(@"登录成功");
            [MXProgressHUD showSuccess:@"登陆成功" toView:weakSelf.view];
            // 修改登录状态
            [MXComUserDefault setHasLogin:YES];
            // 保存账户到本地
            [MXComUserDefault saveUserAccount:phoneNumber];
            // 保存密码到本地
            [MXComUserDefault saveUserPassword:password withAccount:phoneNumber];
            [MXNotificationCenterAccessor postNotificationName:MXNoti_Launch_ChangeVC object:nil ];
        }else {
            NSLog(@"登录失败");
            [MXProgressHUD showError:@"用户名或密码不正确" toView:weakSelf.view];
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"登录失败");
        [MXProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MXProgressHUD showError:@"网络错误，请检查网络" toView:self.view];
    }];
    
}

- (IBAction)forgetPwClick:(UIButton *)sender
{
    MXEnterPhoneViewController *enterPhoneVC = [[MXEnterPhoneViewController alloc] init];
    enterPhoneVC.isResetPwd = YES;
    [self.navigationController pushViewController:enterPhoneVC animated:YES];
}

- (BOOL)judgePhoneNumber:(NSString *)phoneNumber
{
    if (phoneNumber.length == 0) {
        NSLog(@"手机号不能为空");
        return NO;
    }else if(phoneNumber.length != 11) {
        NSLog(@"请输入合法手机号");
        return NO;
    }else {
        return YES;
    }
}

- (BOOL)judgePassword:(NSString *)password
{
    // 不能输入特殊字符
    NSString *str = @"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:password]) {
        NSLog(@"请勿输入特殊字符");
        return NO;
    }
    return YES;
}

@end
