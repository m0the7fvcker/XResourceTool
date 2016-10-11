//
//  MXAppDelegate+EMClient.h
//  MXInteraction
//
//  Created by maRk on 16/10/11.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXAppDelegate.h"

@interface MXAppDelegate (EMClient)


/**
 注册环信SDK
 */
- (void)addEMClient;

- (void)handleEMClientWhenApplicationDidEnterBackground:(UIApplication *)application;

- (void)handleEMClientWhenApplicationWillEnterForeground:(UIApplication *)application;

@end
