//
//  MXLoginHomeViewController.m
//  MXInteraction
//
//  Created by maRk'sTheme on 16/8/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXLoginHomeViewController.h"
#import "MXLoginViewController.h"
#import "MXEnterPhoneViewController.h"
#import "MXForgetPdAndRegisterVC.h"

@interface MXLoginHomeViewController ()


@end

@implementation MXLoginHomeViewController

#pragma mark - 控制器方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

#pragma mark - 初始化方法
-(void)initUI
{
    self.logoImage.image = [UIImage imageNamed:@"login_logo"];
    
    self.registerButton.layer.cornerRadius = 5;
    self.registerButton.layer.borderWidth = 1;
    self.registerButton.layer.borderColor = [UIColor mx_colorWithHexString:@"19b0e9"].CGColor;
    self.registerButton.backgroundColor = [UIColor whiteColor];
    [self.registerButton setTitleColor:[UIColor mx_colorWithHexString:@"19b0e9"] forState:UIControlStateNormal];
    
    self.loginButton.layer.cornerRadius = 5;
    self.loginButton.backgroundColor = [UIColor mx_colorWithHexString:@"19b0e9"];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.tasteLogin setTitleColor:[UIColor mx_colorWithHexString:@"19b0e9"] forState:UIControlStateNormal];
    
}

#pragma mark - 内部方法
- (IBAction)loginApp:(UIButton *)sender
{
    MXLoginViewController *loginVC = [[MXLoginViewController alloc] initWithNibName:@"MXLoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (IBAction)registerAccount:(UIButton *)sender
{
    MXEnterPhoneViewController *enterPhoneVC = [[MXEnterPhoneViewController alloc] initWithNibName:@"MXEnterPhoneViewController" bundle:nil];
    [self.navigationController pushViewController:enterPhoneVC animated:YES];
}

- (IBAction)tasteLogin:(UIButton *)sender
{

}

@end
