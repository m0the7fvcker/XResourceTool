//
//  NSObject+MXExtension.m
//  MXInteraction
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "NSObject+MXExtension.h"
#import <MJExtension/MJExtension.h>

@implementation NSObject (MXExtension)
/**
 *  JSON转模型
 */
+ (id)mx_objectWithKeyValues:(id)values
{
    return  [self mj_objectWithKeyValues:values];
}

+ (id)mx_objectWithKeyValues:(id)values context:(NSManagedObjectContext *)context
{
    return [self mj_objectArrayWithKeyValuesArray:values context:context];
}

/**
 *  字典数组转模型数组
 */
+ (NSMutableArray *)mx_objectArrayWithKeyValuesArray:(id)valuesArr
{
    return [self mj_objectArrayWithKeyValuesArray:valuesArr];
}

/**
 *  模型数组转字典数组
 */
+ (NSMutableArray *)mx_keyValuesArrayWithObjectArray:(NSArray *)objectArr
{
    return [self mj_keyValuesArrayWithObjectArray:objectArr];
}

/**
 *  设置对象数组当中包含的对象
 */
+ (void)mx_setupObjectClassInArray:(NSDictionary *(^)(void))objectClassInArray
{
    [self mj_setupObjectClassInArray:objectClassInArray];
}

/**
 *  模型中的属性名和字典中的key不相同(或者需要多级映射)
 */
+ (void)mx_setupReplacedKeyFromPropertyName:(NSDictionary * (^)(void))replacedKeyFromPropertyName
{
    [self mj_setupReplacedKeyFromPropertyName:replacedKeyFromPropertyName];
}

/**
 *  忽略不归档的属性名
 */
+ (void)mx_setupIgnoredCodingPropertyNames:(NSArray *(^)(void))ignoredCodingPropertyNames
{
    [self mj_setupIgnoredCodingPropertyNames:ignoredCodingPropertyNames];
}

/**
 *  将一个模型转成字典
 */
- (NSMutableDictionary *)mx_keyValues
{
    return self.mj_keyValues;
}

/**
 *  得到JSON字符串
 */
- (NSString *)mx_JSONString
{
    return [self mj_JSONString];
}
@end
