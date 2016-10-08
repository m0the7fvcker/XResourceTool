//
//  MXAppDelegate+Launch.m
//  MXInteraction
//
//  Created by maRk on 16/8/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXAppDelegate+Launch.h"
#import "MXBaseNavigationController.h"
#import "MXLoginHomeViewController.h"
#import "MXHomeViewController.h"
#import "MXLaunchADViewController.h"
#import "MXLaunchNFViewController.h"

#import "MXComUserDefault.h"

@implementation MXAppDelegate (Launch)

- (void)launch
{
    [self addNotification];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 是第一次启动，显示版本特性
    if (![MXComUserDefault isFristLaunch]) {
        
        [MXComUserDefault setIsFristLaunch:YES];
        MXLaunchNFViewController *launchVC = [[MXLaunchNFViewController alloc] init];
        self.window.rootViewController = launchVC;
        [self.window makeKeyAndVisible];
        
    // 不是第一次启动，判断是否登录
    } else {
        
        MXLaunchADViewController *adVC = [[MXLaunchADViewController alloc] init];
        self.window.rootViewController = adVC;
        [self.window makeKeyAndVisible];
    }
}

- (void)changeRootVC:(NSNotification *)noti
{
     NSDictionary *data = noti.userInfo[@"data"];
    
    // 判断是否已经登录
    if ([MXComUserDefault hasLogin]) {
        MXHomeViewController *homeVC = [[MXHomeViewController alloc] init];
//        homeVC.data = data;
        MXBaseNavigationController *navC = [[MXBaseNavigationController alloc] initWithRootViewController:homeVC];
        self.window.rootViewController = navC;
        [self.window makeKeyAndVisible];
        
    // 未登录显示登录
    } else {
        MXLoginHomeViewController *loginVC = [[MXLoginHomeViewController alloc] init];
        MXBaseNavigationController *navC = [[MXBaseNavigationController alloc] initWithRootViewController:loginVC];
        self.window.rootViewController = navC;
        [self.window makeKeyAndVisible];
    }
}

- (void)addNotification
{
    [MXNotificationCenterAccessor addObserver:self selector:@selector(changeRootVC:) name:MXNoti_Launch_ChangeVC object:nil];
}
@end
