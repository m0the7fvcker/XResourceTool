//
//  MXIncomingVC.h
//  MXInteraction
//
//  Created by maRk on 16/10/11.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXBaseViewController.h"
@class EMCallSession;

@interface MXIncomingVC : MXBaseViewController

@property (nonatomic, strong) EMCallSession *callSession;
@property (nonatomic, copy) NSString *remoteIMKey;
@property (nonatomic, copy) NSString *remoteSerial;
@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, assign) BOOL isCaller;

- (instancetype)initWithSessicon:(EMCallSession *)callSession andIsCaller:(BOOL)isCaller;
- (instancetype)initWithIsCaller:(BOOL)isCaller;
- (void)close;
@end
