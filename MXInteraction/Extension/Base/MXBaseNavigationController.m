//
//  MXBaseNavigationController.m
//  MXInteraction
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXBaseNavigationController.h"

@interface MXBaseNavigationController ()

@end

@implementation MXBaseNavigationController

#pragma mark - 控制器方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - 初始化方法
- (void)initUI
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    appearance.translucent = NO;
    
    //设置字体
    appearance.titleTextAttributes = @{
                                       NSForegroundColorAttributeName:[UIColor whiteColor],
                                       NSFontAttributeName:[UIFont systemFontOfSize:17]};
    
    //设置背景颜色
    [appearance setTintColor:[UIColor mx_colorWithHexString:@"12ade7"]];
    [appearance setBarTintColor:[UIColor mx_colorWithHexString:@"12ade7"]];
    [appearance setBackgroundColor:[UIColor mx_colorWithHexString:@"12ade7"]];
    [appearance setBackgroundImage:[UIImage mx_createImageFromColor:[UIColor mx_colorWithHexString:@"12ade7"]] forBarMetrics:UIBarMetricsDefault];
    
    // 去掉导航栏下的下划线
    [appearance setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    appearance.shadowImage = [[UIImage alloc] init];
}


/**
 *  添加返回，隐藏底部bottomBar
 *
 *  @param viewController 需要隐藏的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 添加左边按钮
    [self addLeftBarButtonItem:viewController];
    
    viewController.hidesBottomBarWhenPushed = [self.viewControllers count] > 0;
    [super pushViewController:viewController animated:YES];
}

/**
 *  添加左边返回按钮
 *
 *  @param viewController 需要隐藏的子控制器
 */
- (void)addLeftBarButtonItem:(UIViewController *)viewController
{
    if ([self.childViewControllers count]>0) {
        UIBarButtonItem * leftBarButtonItem = [UIBarButtonItem mx_itemWithImageName:@"navigationbar_back_white" highImageName:nil target:self action:@selector(clickLeftBarButtonItem)];
        viewController.navigationItem.leftBarButtonItem = leftBarButtonItem;
        viewController.hidesBottomBarWhenPushed = YES;
    }
}

- (void)clickLeftBarButtonItem
{
    [self popViewControllerAnimated:YES];
}

@end
