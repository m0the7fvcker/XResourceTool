//
//  MXLog.h
//  MXInteraciton
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXLog : NSObject
+(BOOL)writeLogWithObject:(id)object;
+(BOOL)writeLogWithDic:(NSDictionary *)dic;
+(BOOL)writeLogWithArr:(NSArray *)arr;
+(BOOL)writeLogWithString:(NSString *)string;
@end
