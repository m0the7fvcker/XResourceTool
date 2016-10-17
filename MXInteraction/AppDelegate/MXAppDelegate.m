//
//  MXAppDelegate.m
//  MXInteraction
//
//  Created by maRk'sTheme on 16/7/28.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXAppDelegate.h"
#import "MXAppDelegate+JSPath.h"
#import "MXAppDelegate+Push.h"
#import "MXAppDelegate+Launch.h"
#import "MXAppDelegate+EMClient.h"

@interface MXAppDelegate ()

@end

@implementation MXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self addJSPath];
    [self addPushWithApplication:application];
    [self addEMClient];
    [self launch];
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self handleEMClientWhenApplicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self handleEMClientWhenApplicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

- (void)dealloc
{
    [MXNotificationCenterAccessor removeObserver:self];
}
@end
