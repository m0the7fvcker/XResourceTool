//
//  MXRequestModel.h
//  MXInteraction
//
//  Created by maRk on 16/8/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXRequestModel : NSObject
@property (nonatomic, strong) id task;
+ (MXRequestModel *)newWithTask:(id)task;

- (BOOL)isFinish;
- (void)cancel;
@end
