//
//  MXLanguage.m
//  MXInteraciton
//
//  Created by maRk on 16/8/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXLanguage.h"

@implementation MXLanguage
+(NSString *)stringWithKey:(NSString *)key{
    return NSLocalizedString(key, key);
}
@end
