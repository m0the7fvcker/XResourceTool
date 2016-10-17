//
//  MXHomeMessageVC.m
//  MXInteraction
//
//  Created by maRk on 16/10/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHomeMessageVC.h"

@interface MXHomeMessageVC ()

@end

@implementation MXHomeMessageVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI
{
    self.title = @"小区公告";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, 20)];
    label.text = @"暂无公告";
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.centerX = self.view.centerX;
    label.centerY = self.view.centerY - 64;
    [self.view addSubview:label];
}

@end
