//
//  MXIncomingVC.h
//  MXInteraction
//
//  Created by maRk on 16/10/11.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXBaseViewController.h"

@interface MXIncomingVC : MXBaseViewController

- (instancetype)initWithSessicon:(EMCallSession *)callSession andIsCaller:(BOOL)isCaller;
- (void)close;

@end
