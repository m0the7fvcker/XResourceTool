//
//  MXLoginViewController.m
//  MXInteraction
//
//  Created by maRk'sTheme on 16/8/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXLoginViewController.h"
#import "MXForgetPdViewController.h"
#import "MXTextField.h"

@interface MXLoginViewController ()


@end

@implementation MXLoginViewController

#pragma mark - 父类方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavBar{
    self.title = @"登录";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerVC)];
}

-(void)initUI{
    
    NSLog(@"name frame :%@",NSStringFromCGRect(self.nameTextField.frame));
    
    //[self.view addUnderLineWithFrame:self.nameTextField.frame];
    //[self.view addUnderLineWithFrame:self.pdTextField.frame];
}

-(void)initConstraint{
    
}

- (void)changeTheme{
    
}

- (void)registerVC{
  
}
- (IBAction)loginApp:(UIButton *)sender {
    
    
    
}
- (IBAction)forgetPd:(UIButton *)sender {
    
    MXForgetPdViewController * forgetVC = [[MXForgetPdViewController alloc]initWithNibName:@"MXForgetPdViewController" bundle:nil];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:forgetVC animated:YES];
}

@end
