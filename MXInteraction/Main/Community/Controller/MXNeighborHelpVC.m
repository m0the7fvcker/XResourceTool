//
//  MXNeighborHelpVC.m
//  MXInteraction
//
//  Created by maRk on 16/8/25.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXNeighborHelpVC.h"

@implementation MXNeighborHelpVC

#pragma mark - 控制器方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavBar];
    [self initUI];
    [self initConstraint];
}

#pragma mark - 初始化方法
- (void)initNavBar
{
    
}

- (void)initUI
{
    self.title = @"邻里互帮";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
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
