//
//  MXLog.m
//  MXInteraction
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXLog.h"
#import "NSObject+MXExtension.h"

@implementation MXLog
+(BOOL)writeLogWithObject:(id)object{
    NSString * string =[object MX_JSONString];
    return [self writeLogWithString:string];
}

+(BOOL)writeLogWithDic:(NSDictionary *)dic{
    NSString * string =[dic MX_JSONString];
    return [self writeLogWithString:string];
}

+(BOOL)writeLogWithArr:(NSArray *)arr{
    NSString * string =[arr MX_JSONString];
    return [self writeLogWithString:string];
}

+(BOOL)writeLogWithString:(NSString *)string{
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    NSString * yyyymmdd = [dateFormatter stringFromDate:date];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString * dateString = [dateFormatter stringFromDate:date];
    NSString * writeString = [NSString stringWithFormat:@"%@:%@",dateString,string];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSMutableString * path = [[paths firstObject] mutableCopy];
    [path appendFormat:@"/%@.txt",yyyymmdd];
    NSStringEncoding encoding = NSUTF8StringEncoding;
    NSString * fileString = [NSString stringWithContentsOfFile:path usedEncoding:&encoding error:nil];
    if (fileString == nil) {
        fileString = @"";
    }
    
    NSString * writeFileString = [NSString stringWithFormat:@"%@\n%@",fileString,writeString];
    
    return [writeFileString writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
}
@end
