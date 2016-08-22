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

@interface MXLoginViewController ()<UITextFieldDelegate>

@end

@implementation MXLoginViewController

#pragma mark - 控制器方法
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - 内部方法
- (IBAction)loginClick:(UIButton *)sender
{
    // 修改登录状态
    [MXComUserDefault setHasLogin:YES];
    
    MXHomeViewController *homeVC = [[MXHomeViewController alloc] init];
    [self.navigationController pushViewController:homeVC animated:YES];
}

- (IBAction)forgetPwClick:(UIButton *)sender
{
    MXEnterPhoneViewController *enterPhoneVC = [[MXEnterPhoneViewController alloc] init];
    [self.navigationController pushViewController:enterPhoneVC animated:YES];
}

@end
