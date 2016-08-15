//
//  MXKeychain.m
//  MXInteraciton
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXKeychain.h"
#import <SSKeychain/SSKeychain.h>

static NSString *MXKeychainServiceKey = @"com.13322.lawyer";

@implementation MXKeychain
+ (NSString *)passwordWithAccount:(NSString *)account{
    NSError *err;
    NSString *psw = [SSKeychain passwordForService:MXKeychainServiceKey account:account error:&err];
    if (err == nil) {
        return psw;
    }
    if ([err code] == errSecItemNotFound) {
        NSLog(@"Password not found");
    } else if (err != nil) {
        NSLog(@"Some other error occurred: %@", [err localizedDescription]);
    }
    return nil;
}

+ (BOOL)deletePassword:(NSString *)account{
    return [SSKeychain deletePasswordForService:MXKeychainServiceKey account:account];
}

+ (BOOL)setPassword:(NSString *)password account:(NSString *)account{
    return [SSKeychain setPassword:password forService:MXKeychainServiceKey account:account];
}
@end
