//
//  NSString+MXCategory.m
//  MXInteraction
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "NSString+MXCategory.h"

@implementation NSString (MXCategory)
- (CGSize)mx_sizeWithFont:(UIFont *)font andConstrainedSize:(CGSize)constrainedSize
{
    CGSize newSize;
    
    NSDictionary *attributes = @{NSFontAttributeName:font};
    
    newSize = [self boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return newSize;
}
@end
