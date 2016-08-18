//
//  NSObject+MXExtension.h
//  MXInteraction
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSManagedObjectContext;

@interface NSObject (MXExtension)
/**
 *  @brief  JSON字符串转模型
 *
 *  @param values JSON字符
 *
 *  @return id
 */
+(id)mx_objectWithKeyValues:(id)values;

/**
 *  @brief  Core Data JSON字符串转模型
 *
 *  @param values  JSON字符
 *  @param context
 *
 *  @return 模型
 */
+(id)mx_objectWithKeyValues:(id)values context:(NSManagedObjectContext *)context;

/**
 *  @brief  JSON array -> model array【将一个字典数组转成模型数组】
 *
 *  @param valuesArr json 数组
 *
 *  @return NSMutableArray 模型数组
 */
+(NSMutableArray *)mx_objectArrayWithKeyValuesArray:(id)valuesArr;

/**
 *  @brief  Model array -> JSON array【将一个模型数组转成字典数组】
 *
 *  @param objectArr 模型数组
 *
 *  @return 字典数组
 */
+(NSMutableArray *)mx_keyValuesArrayWithObjectArray:(NSArray *)objectArr;

/**
 *  @brief  设置对象数组当中包含的对象
 *
 *  @param ObjectClassInArray key:数组的属性名,value:包含对象的类名
 */
+(void)mx_setupObjectClassInArray:(NSDictionary *(^)(void))objectClassInArray;

/**
 *  @brief  Model name - JSON key mapping【模型中的属性名和字典中的key不相同(或者需要多级映射)】
 *
 *  @param replacedKeyFromPropertyName 替换的键值和属性名
 */
+(void)mx_setupReplacedKeyFromPropertyName:(NSDictionary * (^)(void))replacedKeyFromPropertyName;

/**
 *  @brief  coding
 *
 *  @param ignoredCodingPropertyNames 忽略不归档的属性名
 */
+(void)mx_setupIgnoredCodingPropertyNames:(NSArray *(^)(void))ignoredCodingPropertyNames;

/**
 *  @brief   Model -> JSON【将一个模型转成字典】
 *
 *  @return  字典
 */
-(NSMutableDictionary *)mx_keyValues;

/**
 *  得到json字符串
 *
 *  @return json字符串
 */
- (NSString *)mx_JSONString;
@end
