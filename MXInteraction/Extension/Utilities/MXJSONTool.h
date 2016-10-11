//
//  MXJSONTool.h
//  MXInteraction
//
//  Created by maRk on 16/10/11.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXJSONTool : NSObject

/**
 JSON字符串转为字典

 @param jsonString JSON字符串

 @return 字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


/**
 字典转为JSON字符串

 @param dic 需转字典

 @return JSON字符串
 */
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;
@end
