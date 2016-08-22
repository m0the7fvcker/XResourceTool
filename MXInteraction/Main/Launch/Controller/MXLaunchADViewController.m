//
//  MXLaunchADViewController.m
//  MXInteraction
//
//  Created by maRk on 16/8/22.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXLaunchADViewController.h"

@interface MXLaunchADViewController ()

@end

@implementation MXLaunchADViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor mx_randomColor];
    UIButton *jumpBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    jumpBtn.frame = CGRectMake(100, 100, 100, 100);
    [jumpBtn addTarget:self action:@selector(jumpToHome) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpBtn];
}

- (void)jumpToHome
{
    [MXNotificationCenterAccessor postNotificationName:MXNoti_Launch_ChangeVC object:nil];
}



@end
