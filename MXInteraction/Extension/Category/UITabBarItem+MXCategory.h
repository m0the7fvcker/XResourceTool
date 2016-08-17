//
//  UITabBarItem+MXCategory.h
//  MXInteraction
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarItem (MXCategory)
/**
 *  设置正常图片和选中图片
 *
 *  @param title
 *  @param imgName
 *  @param selImgName
 */
- (void)MX_setTitle:(NSString *)title norImgName:(NSString *)imgName selImgName:(NSString *)selImgName;
/**
 *  设置正常图片和选中图片
 *
 *  @param title
 *  @param imgName
 *  @param selImgName
 */
- (void)MX_setTitle:(NSString *)title norImg:(UIImage *)norImg selImg:(UIImage *)selImg;
@end
