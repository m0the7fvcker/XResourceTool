//
//  MXMenuViewController.m
//  MXInteraciton
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXMenuViewController.h"

@interface MXMenuViewController ()

@end

@implementation MXMenuViewController

#pragma mark - 控制器方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initViewModel];
    [self initNavBar];
    [self initUI];
    [self initConstraint];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"");
}

#pragma mark - 初始化方法
- (void)initViewModel
{
    
}

- (void)initNavBar
{
    
}

- (void)initUI
{
    
}

- (void)initConstraint
{
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}

#pragma mark - 内部方法


@end
