//
//  MXHomeServiceVC.m
//  MXInteraction
//
//  Created by maRk on 16/8/31.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHomeServiceVC.h"

@interface MXHomeServiceVC ()

@end

@implementation MXHomeServiceVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor mx_colorWithHexString:@"ececec"];
    
    self.kongTiao.layer.cornerRadius = 2;
    self.kongTiao.layer.borderWidth = 0.5;
    self.kongTiao.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.bingXiang.layer.cornerRadius = 2;
    self.bingXiang.layer.borderWidth = 0.5;
    self.bingXiang.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.shuiGuan.layer.cornerRadius = 2;
    self.shuiGuan.layer.borderWidth = 0.5;
    self.shuiGuan.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.wangLuo.layer.cornerRadius = 2;
    self.wangLuo.layer.borderWidth = 0.5;
    self.wangLuo.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.louShui.layer.cornerRadius = 2;
    self.louShui.layer.borderWidth = 0.5;
    self.louShui.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.qiTa.layer.cornerRadius = 2;
    self.qiTa.layer.borderWidth = 0.5;
    self.qiTa.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.tiJiao.layer.cornerRadius = 5;
}
@end
