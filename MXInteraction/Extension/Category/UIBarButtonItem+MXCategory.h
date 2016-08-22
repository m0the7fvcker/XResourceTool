//
//  UIBarButtonItem+MXCategory.h
//  MXInteraction
//
//  Created by maRk on 16/8/22.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MXCategory)
/**
 *  @brief  得到UIBarButtonItem
 *
 *  @param imageName     正常图片的名字
 *  @param highImageName 高亮图片的名字
 *  @param target        回调的target
 *  @param action        回调方法
 *
 *  @return UIBarButtonItem 实例
 */
+ (UIBarButtonItem *)mx_itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;
@end
