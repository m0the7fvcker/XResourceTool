//
//  MXHomeElevatorVC.m
//  MXInteraction
//
//  Created by maRk on 16/8/31.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHomeElevatorVC.h"

@interface MXHomeElevatorVC ()

@end

@implementation MXHomeElevatorVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI
{
    self.callView.layer.cornerRadius = 5;
}

- (IBAction)callElevatorClick:(UIButton *)sender
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    [MXProgressHUD showError:@"未与电梯模块对接" toView:nil];
}
@end
