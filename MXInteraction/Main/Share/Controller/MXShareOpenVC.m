//
//  MXShareOpenVC.m
//  MXInteraction
//
//  Created by maRk on 16/8/31.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXShareOpenVC.h"

@interface MXShareOpenVC ()

@end

@implementation MXShareOpenVC

#pragma mark - 控制器方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - 初始化方法
- (void)initNavBar
{
    
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor mx_colorWithHexString:@"ececec"];
    self.shareCodeButton.backgroundColor = [UIColor mx_colorWithHexString:@"12ade7"];
}

- (IBAction)shareQRCodeClick:(UIButton *)sender {
}


@end
