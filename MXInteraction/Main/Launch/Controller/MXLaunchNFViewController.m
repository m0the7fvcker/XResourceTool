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
