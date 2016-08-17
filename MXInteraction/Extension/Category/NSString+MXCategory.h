//
//  NSString+MXCategory.h
//  MXInteraction
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MXCategory)
/**
 *  根据字体大小和约束大小返回字符串的size
 *
 *  @param font            字体大小
 *  @param constrainedSize 约束大小
 *
 *  @return 新的size
 */
- (CGSize)MX_sizeWithFont:(UIFont *)font andConstrainedSize:(CGSize)constrainedSize;
@end
