//
//  MXLaunchNFViewController.m
//  MXInteraction
//
//  Created by maRk on 16/8/22.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXLaunchNFViewController.h"

@interface MXLaunchNFViewController ()

@end

@implementation MXLaunchNFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, 30)];
    label.text = @"版本新特性";
    label.textAlignment = NSTextAlignmentCenter;
    label.center = self.view.center;
    
    UIButton *jumpBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    jumpBtn.frame = CGRectMake(0, 100, 10, 10);
    [jumpBtn addTarget:self action:@selector(jumpToHome) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpBtn];
}

- (void)jumpToHome
{
    [MXNotificationCenterAccessor postNotificationName:MXNoti_Launch_ChangeVC object:nil];
}

@end
