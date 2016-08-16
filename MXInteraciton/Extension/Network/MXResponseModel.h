//
//  MXResponseModel.h
//  MXInteraciton
//
//  Created by maRk on 16/8/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXResponseModel : NSObject
@property (nonatomic, strong) id task;
@property (nonatomic, strong) MXBaseDataModel *baseModel;
@property (nonatomic, strong) NSError *err;
+(MXResponseModel *)newWithTask:(id)task baseModel:(MXBaseDataModel *)baseModel;
+(MXResponseModel *)newWithTask:(id)task err:(NSError *)err;
@end
