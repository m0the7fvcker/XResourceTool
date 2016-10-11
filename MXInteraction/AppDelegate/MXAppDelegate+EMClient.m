//
//  MXAppDelegate+EMClient.m
//  MXInteraction
//
//  Created by maRk on 16/10/11.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXAppDelegate+EMClient.h"

@implementation MXAppDelegate (EMClient)

- (void)addEMClient
{
    //easemob-demo#chatdemoui
    //1192161008178084#huaxin
    //mohmoo#mohmoo
    
    EMOptions *options = [EMOptions optionsWithAppkey:@"mohmoo#mohmoo"];
    options.apnsCertName = @"istore_dev";
    options.isAutoAcceptGroupInvitation = YES;
//    options.enableConsoleLog = YES;
    
    [[EMClient sharedClient] initializeSDKWithOptions:options];
}

- (void)handleEMClientWhenApplicationDidEnterBackground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)handleEMClientWhenApplicationWillEnterForeground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

@end
