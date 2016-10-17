//
//  MXOpenRecordModel.m
//  MXInteraction
//
//  Created by maRk on 16/10/17.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXOpenRecordModel.h"

@implementation MXOpenRecordModel

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.time forKey:@"time"];
    [aCoder encodeObject:self.result forKey:@"result"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        self.time = [aDecoder decodeObjectForKey:@"time"];
        self.result = [aDecoder decodeObjectForKey:@"result"];
    }
    return self;
}

@end
