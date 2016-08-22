//
//  MXEnterPhoneViewController.m
//  MXInteraction
//
//  Created by maRk'sTheme on 16/8/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXEnterPhoneViewController.h"
#import "MXForgetPdAndRegisterVC.h"

@interface MXEnterPhoneViewController ()

@end

@implementation MXEnterPhoneViewController

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
    
}

#pragma mark - 内部方法
- (IBAction)comfirmChange:(UIButton *)sender
{
    MXForgetPdAndRegisterVC *registerVC = [[MXForgetPdAndRegisterVC alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

@end
