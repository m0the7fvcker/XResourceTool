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
    self.comfirmPhoneTF.layer.cornerRadius = 5;
    self.comfirmPhoneTF.layer.borderWidth = 1;
    self.comfirmPhoneTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.confirmBtn.layer.cornerRadius = 5;
    self.confirmBtn.backgroundColor = [UIColor mx_colorWithHexString:@"19b0e9"];
    [self.confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

#pragma mark - 内部方法
- (IBAction)comfirmChange:(UIButton *)sender
{
    MXForgetPdAndRegisterVC *registerVC = [[MXForgetPdAndRegisterVC alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

@end
