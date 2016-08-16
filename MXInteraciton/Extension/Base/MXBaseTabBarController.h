//
//  MXBaseTabBarController.h
//  MXInteraction
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXBaseNavigationController.h"

@interface MXBaseTabBarController : UITabBarController
/**
 *  @brief 子类重写此方法初始化配置
 */
-(void)initConfigure;

/**
 *  @brief 根据VC得到nav
 *
 *  @param viewController 根控制器
 *
 *  @return 导航控制器
 */
-(MXBaseNavigationController *)navWithVC:(UIViewController *)viewController;
@end
