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

@interface MXForgetPdAndRegisterVC ()

@end

@implementation MXForgetPdAndRegisterVC

#pragma mark - 控制器方法
- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - 内部方法
- (IBAction)getCode:(UIButton *)sender
{
    
}

- (IBAction)goNext:(UIButton *)sender
{
    // 修改登录状态
    [MXComUserDefault setHasLogin:YES];
    
    MXHomeViewController *homeVC = [[MXHomeViewController alloc] init];
    [self.navigationController pushViewController:homeVC animated:YES];
}


@end
