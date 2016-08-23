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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  隐藏底部bottomBar
 *
 *  @param viewController 需要隐藏的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed = [self.viewControllers count] > 0;
    [super pushViewController:viewController animated:YES];
}

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
@end
