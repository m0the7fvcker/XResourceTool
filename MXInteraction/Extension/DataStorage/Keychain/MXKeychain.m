//
//  MXKeychain.m
//  MXInteraction
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXKeychain.h"
#import <SAMKeychain/SAMKeychain.h>

static NSString *MXKeychainServiceKey = @"com.max1ao.mxinteraction";

@implementation MXKeychain
+ (NSString *)passwordWithAccount:(NSString *)account{
    NSError *err;
    NSString *psw = [SAMKeychain passwordForService:MXKeychainServiceKey account:account error:&err];
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
    return [SAMKeychain deletePasswordForService:MXKeychainServiceKey account:account];
}

+ (BOOL)setPassword:(NSString *)password account:(NSString *)account{
    BOOL suc = [SAMKeychain setPassword:password forService:MXKeychainServiceKey account:account];
    return suc;
}
@end
