//
//  MXRequestModel.m
//  MXInteraction
//
//  Created by maRk on 16/8/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXRequestModel.h"

@implementation MXRequestModel
+ (MXRequestModel *)newWithTask:(id)task
{
    MXRequestModel * model = [[MXRequestModel alloc]init];
    model.task = task;
    return  model;
}

- (BOOL)isFinish
{
    NSURLSessionDataTask *task = self.task;
    return task.state == NSURLSessionTaskStateCompleted;
}

- (void)cancel
{
    NSURLSessionDataTask *task = self.task;
    [task cancel];
}
@end
