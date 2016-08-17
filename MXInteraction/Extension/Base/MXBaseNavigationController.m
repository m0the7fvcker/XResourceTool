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
    // Do any additional setup after loading the view.
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
@end
