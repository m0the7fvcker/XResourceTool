//
//  NSObject+MXExtension.m
//  MXInteraciton
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "NSObject+MXExtension.h"
#import <MJExtension/MJExtension.h>

@implementation NSObject (MXExtension)
#pragma mark - JSON字符串转模型
+(id)MX_ObjectWithKeyValues:(id)values
{
    return  [self mj_objectWithKeyValues:values];
}

+(id)MX_ObjectWithKeyValues:(id)values context:(NSManagedObjectContext *)context
{
    return [self mj_objectArrayWithKeyValuesArray:values context:context];
}

#pragma mark - 将一个字典数组转成模型数组
+(NSMutableArray *)MX_ObjectArrayWithKeyValuesArray:(id)valuesArr
{
    return [self mj_objectArrayWithKeyValuesArray:valuesArr];
}

#pragma mark - 模型数组转字典
+(NSMutableArray *)MX_KeyValuesArrayWithObjectArray:(NSArray *)objectArr
{
    return [self mj_keyValuesArrayWithObjectArray:objectArr];
}

#pragma mark - 设置对象数组当中包含的对象
+(void)MX_SetupObjectClassInArray:(NSDictionary *(^)(void))objectClassInArray
{
    [self mj_setupObjectClassInArray:objectClassInArray];
}

#pragma mark - 模型中的属性名和字典中的key不相同(或者需要多级映射)
+(void)MX_SetupReplacedKeyFromPropertyName:(NSDictionary * (^)(void))replacedKeyFromPropertyName
{
    [self mj_setupReplacedKeyFromPropertyName:replacedKeyFromPropertyName];
}

#pragma mark - 忽略不归档的属性名
+(void)MX_SetupIgnoredCodingPropertyNames:(NSArray *(^)(void))ignoredCodingPropertyNames
{
    [self mj_setupIgnoredCodingPropertyNames:ignoredCodingPropertyNames];
}

#pragma mark - 将一个模型转成字典
-(NSMutableDictionary *)MX_KeyValues
{
    return self.mj_keyValues;
}

#pragma mark - 得到json字符串
- (NSString *)MX_JSONString{
    return [self mj_JSONString];
}
@end
