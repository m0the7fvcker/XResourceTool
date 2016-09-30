//
//  MXProgressHUD.h
//  MXInteraction
//
//  Created by maRk on 16/9/30.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MBProgressHUD;

@interface MXProgressHUD : NSObject

/**
 显示错误信息

 @param error 错误信息
 @param view  添加的View
 */
+ (void)showError:(NSString *)error toView:(UIView *)view;


/**
 显示成功信息

 @param success 成功信息
 @param view    添加的View
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;


/**
 添加自定义信息

 @param message 自定义信息
 @param view    添加的View

 @return MBProgressHUD
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


/**
 隐藏蒙板

 @param view     需要隐藏的View
 @param animated 是否动画

 @return 是否动画
 */
+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;
@end
