//
//  MXForgetPdViewController.m
//  MXInteraction
//
//  Created by maRk'sTheme on 16/8/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXForgetPdViewController.h"
#import "MXResetPdViewController.h"

@interface MXForgetPdViewController ()

@end

@implementation MXForgetPdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)getCode:(UIButton *)sender {
    
}
- (IBAction)goNext:(UIButton *)sender {
    
    MXResetPdViewController * resetPd = [[MXResetPdViewController alloc]initWithNibName:@"LYResetPdViewController" bundle:nil];
    [self.navigationController pushViewController:resetPd animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
