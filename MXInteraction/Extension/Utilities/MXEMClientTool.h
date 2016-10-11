//
//  MXEMClientTool.h
//  MXInteraction
//
//  Created by maRk on 16/10/11.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MXSeeTalkingVC.h"
#import "MXMonitoringVC.h"
#import "MXIncomingVC.h"

@interface MXEMClientTool : NSObject

@property (nonatomic, strong) MXMonitoringVC *monitorVC;
@property (nonatomic, strong) MXIncomingVC *incomingVC;

+ (MXEMClientTool *)shareTool;

- (BOOL)sendCMD:(NSDictionary *)cmd to:(NSString *)to;

- (BOOL)sendCallTo:(NSString *)to;

@end
