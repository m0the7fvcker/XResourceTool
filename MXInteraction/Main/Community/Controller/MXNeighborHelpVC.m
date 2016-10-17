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
    self.view.backgroundColor = [UIColor mx_colorWithHexString:@"F3F2F2"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.centerY - 100, MXScreen_Width, 20)];
    centerLabel.textAlignment = NSTextAlignmentCenter;
    centerLabel.textColor = [UIColor mx_colorWithHexString:@"605d5d"];
    centerLabel.font = [UIFont systemFontOfSize:18];
    centerLabel.text = @"暂无任何互帮消息";
    [self.view addSubview:centerLabel];
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
