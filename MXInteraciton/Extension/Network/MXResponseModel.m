//
//  MXResponseModel.m
//  MXInteraciton
//
//  Created by maRk on 16/8/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXResponseModel.h"

@implementation MXResponseModel
+(MXResponseModel *)newWithTask:(id)task baseModel:(MXBaseDataModel *)baseModel
{
    MXResponseModel * model = [[MXResponseModel alloc]init];
    model.task = task;
    model.baseModel = baseModel;
    return  model;
}

+(MXResponseModel *)newWithTask:(id)task err:(NSError *)err
{
    MXResponseModel * model = [[MXResponseModel alloc]init];
    model.task = task;
    model.err = err;
    return  model;
}
@end
