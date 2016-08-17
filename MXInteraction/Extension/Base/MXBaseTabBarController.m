//
//  MXBaseTabBarController.m
//  MXInteraction
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXBaseTabBarController.h"

@interface MXBaseTabBarController ()

@end

@implementation MXBaseTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  @brief 子类重写此方法初始化配置
 */
-(void)initConfigure
{
    
}

- (void)initTabBarItem: (UITabBarItem *)item nomailImage: (NSString *)nImgName selImage: (NSString *)sImgName
{
    item.image = [[UIImage imageNamed:nImgName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item.selectedImage = [[UIImage imageNamed:sImgName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

/**
 *  @brief 根据VC得到nav
 *
 *  @param viewController 根控制器
 *
 *  @return 导航控制器
 */
-(MXBaseNavigationController *)navWithVC:(UIViewController *)viewController
{
    MXBaseNavigationController *naVC = [[MXBaseNavigationController alloc] initWithRootViewController:viewController];
    return naVC;
}


@end
