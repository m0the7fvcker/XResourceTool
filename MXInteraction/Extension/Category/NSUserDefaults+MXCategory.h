//
//  NSUserDefaults+MXCategory.h
//  MXInteraction
//
//  Created by maRk on 16/8/17.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (MXCategory)

/** getter方法 */
+ (id)objectForKey:(NSString *)defaultName;
+ (NSString *)stringForKey:(NSString *)defaultName;
+ (NSArray *)arrayForKey:(NSString *)defaultName;
+ (NSDictionary<NSString *, id> *)dictionaryForKey:(NSString *)defaultName;
+ (NSData *)dataForKey:(NSString *)defaultName;
+ (NSArray<NSString *> *)stringArrayForKey:(NSString *)defaultName;
+ (NSInteger)integerForKey:(NSString *)defaultName;
+ (float)floatForKey:(NSString *)defaultName;
+ (double)doubleForKey:(NSString *)defaultName;
+ (BOOL)boolForKey:(NSString *)defaultName;
+ (NSURL *)URLForKey:(NSString *)defaultName ;



/** setter方法 */
+ (void)setObject:(id)value forKey:(NSString *)defaultName ;
+ (void)removeObjectForKey:(NSString *)defaultName ;
+ (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName ;
+ (void)setFloat:(float)value forKey:(NSString *)defaultName ;
+ (void)setDouble:(double)value forKey:(NSString *)defaultName ;
+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName ;
+ (void)setURL:(NSURL *)url forKey:(NSString *)defaultName ;


+ (void)setObject:(id)value forKey:(NSString *)defaultName synchronize:(BOOL)synchronize;
+ (void)removeObjectForKey:(NSString *)defaultName synchronize:(BOOL)synchronize;
+ (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName synchronize:(BOOL)synchronize;
+ (void)setFloat:(float)value forKey:(NSString *)defaultName synchronize:(BOOL)synchronize;
+ (void)setDouble:(double)value forKey:(NSString *)defaultName synchronize:(BOOL)synchronize;
+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName synchronize:(BOOL)synchronize;
+ (void)setURL:(NSURL *)url forKey:(NSString *)defaultName synchronize:(BOOL)synchronize;
+ (BOOL)synchronize;
@end
