//
//  MXAppDelegate+JSPath.m
//  MXInteraction
//
//  Created by maRk on 16/8/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXAppDelegate+JSPath.h"
#import <JSPatch/JSPatch.h>

@implementation MXAppDelegate (JSPath)
- (void)addJSPath
{
    [JSPatch startWithAppKey:@"5189da53fbc740d5"];
    [JSPatch sync];
}
@end
