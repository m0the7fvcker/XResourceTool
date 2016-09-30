//
//  MXProgressHUD.m
//  MXInteraction
//
//  Created by maRk on 16/9/30.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXProgressHUD.h"
#import "MBProgressHUD.h"

@implementation MXProgressHUD

/**
 显示信息

 @return nil
 */
+ (void)show:(NSString *)text icon:(NSString *)icon toView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1];
}

/**
 显示错误

 @return nil
 */
+ (void)showError:(NSString *)error toView:(UIView *)view
{
    [self show:error icon:@"error.png" toView:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" toView:view];
}

/**
 显示一些信息

 @param message 提示信息

 @return HUD
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    
    return hud;
}

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated
{
    return [MBProgressHUD hideHUDForView:view animated:animated];
}
@end
