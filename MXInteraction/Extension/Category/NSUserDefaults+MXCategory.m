//
//  NSUserDefaults+MXCategory.m
//  MXInteraction
//
//  Created by maRk on 16/8/17.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "NSUserDefaults+MXCategory.h"

#define MXUDStandard [NSUserDefaults standardUserDefaults]
#define Synchronize if (synchronize) {[self synchronize];}

@implementation NSUserDefaults (MXCategory)

#pragma mark - getter
+ (id)objectForKey:(NSString *)defaultName
{
    return [MXUDStandard objectForKey:defaultName];
}

+ (NSString *)stringForKey:(NSString *)defaultName
{
    return [MXUDStandard stringForKey:defaultName];
}

+ (NSArray *)arrayForKey:(NSString *)defaultName
{
    return [MXUDStandard arrayForKey:defaultName];
}

+ (NSDictionary<NSString *, id> *)dictionaryForKey:(NSString *)defaultName
{
    return [MXUDStandard dictionaryForKey:defaultName];
}

+ (NSData *)dataForKey:(NSString *)defaultName
{
    return [MXUDStandard dataForKey:defaultName];
}

+ (NSArray<NSString *> *)stringArrayForKey:(NSString *)defaultName
{
    return [MXUDStandard stringArrayForKey:defaultName];
}

+ (NSInteger)integerForKey:(NSString *)defaultName
{
    return [MXUDStandard integerForKey:defaultName];
}

+ (float)floatForKey:(NSString *)defaultName
{
    return [MXUDStandard floatForKey:defaultName];
}

+ (double)doubleForKey:(NSString *)defaultName
{
    return [MXUDStandard doubleForKey:defaultName];
}

+ (BOOL)boolForKey:(NSString *)defaultName
{
    return [MXUDStandard boolForKey:defaultName];
}

+ (NSURL *)URLForKey:(NSString *)defaultName
{
    return [MXUDStandard URLForKey:defaultName];
}


#pragma mark - setter

+ (void)setObject:(id)value forKey:(NSString *)defaultName
{
    [MXUDStandard setObject:value forKey:defaultName];
}

+ (void)removeObjectForKey:(NSString *)defaultName
{
    [MXUDStandard removeObjectForKey:defaultName];
}

+ (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName
{
    [MXUDStandard setInteger:value forKey:defaultName];
}

+ (void)setFloat:(float)value forKey:(NSString *)defaultName
{
    [MXUDStandard setFloat:value forKey:defaultName];
}

+ (void)setDouble:(double)value forKey:(NSString *)defaultName
{
    [MXUDStandard setDouble:value forKey:defaultName];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName
{
    [MXUDStandard setBool:value forKey:defaultName];
}

+ (void)setURL:(NSURL *)url forKey:(NSString *)defaultName
{
    [MXUDStandard setURL:url forKey:defaultName];
}

+ (void)setObject:(id)value forKey:(NSString *)defaultName synchronize:(BOOL)synchronize
{
    [self setObject:value forKey:defaultName];
    Synchronize
}

+ (void)removeObjectForKey:(NSString *)defaultName synchronize:(BOOL)synchronize
{
    [self removeObjectForKey:defaultName];
    Synchronize
}

+ (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName synchronize:(BOOL)synchronize
{
    [self setInteger:value forKey:defaultName];
    Synchronize
}

+ (void)setFloat:(float)value forKey:(NSString *)defaultName synchronize:(BOOL)synchronize
{
    [self setFloat:value forKey:defaultName];
    Synchronize
}

+ (void)setDouble:(double)value forKey:(NSString *)defaultName synchronize:(BOOL)synchronize
{
    [self setDouble:value forKey:defaultName];
    Synchronize
}

+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName synchronize:(BOOL)synchronize
{
    [self setBool:value forKey:defaultName];
    Synchronize
}

+ (void)setURL:(NSURL *)url forKey:(NSString *)defaultName synchronize:(BOOL)synchronize
{
    [self setURL:url forKey:defaultName];
    Synchronize
}

+ (BOOL)synchronize
{
    return [MXUDStandard synchronize];
}
@end
