//
//  MXHomeChangePwVC.m
//  MXInteraction
//
//  Created by maRk on 16/10/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHomeChangePwVC.h"
#import "MXHttpRequest+LoginAndRegister.h"

@interface MXHomeChangePwVC ()
@property (weak, nonatomic) IBOutlet UITextField *currentPwTf;
@property (weak, nonatomic) IBOutlet UITextField *changedPwTf;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwTf;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *currentPwEye;
@property (weak, nonatomic) IBOutlet UIButton *changedPwEye;
@property (weak, nonatomic) IBOutlet UIButton *confirmPwEye;
@end

@implementation MXHomeChangePwVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.submitBtn.backgroundColor = [UIColor mx_colorWithHexString:@"24AEE4"];
    self.submitBtn.layer.cornerRadius = 5;
}
- (IBAction)currentEyeClick:(UIButton *)sender
{
    self.currentPwTf.secureTextEntry = !self.currentPwTf.secureTextEntry;
    
    NSString* text = self.currentPwTf.text;
    self.currentPwTf.text = @" ";
    self.currentPwTf.text = text;
}

- (IBAction)changedEyeClick:(UIButton *)sender
{
    self.changedPwTf.secureTextEntry = !self.changedPwTf.secureTextEntry;
    
    NSString* text = self.changedPwTf.text;
    self.changedPwTf.text = @" ";
    self.changedPwTf.text = text;
}

- (IBAction)confirmEyeClick:(UIButton *)sender
{
    self.confirmPwTf.secureTextEntry = !self.confirmPwTf.secureTextEntry;
    
    NSString* text = self.confirmPwTf.text;
    self.confirmPwTf.text = @" ";
    self.confirmPwTf.text = text;
}

- (IBAction)submitClick:(UIButton *)sender
{
    if (![self.changedPwTf.text isEqualToString:self.confirmPwTf.text]) {
        [MXProgressHUD showError:@"两次输入的新密码不一致" toView:nil];
    }else {
        [MXHttpRequest ChangePasswordWithOldPassword:self.currentPwTf.text andNewPassword:self.confirmPwTf.text success:^(MXBaseDataModel * _Nonnull responseModel) {
            switch (responseModel.status) {
                case 0:
                {
                    [MXProgressHUD showSuccess:@"修改成功" toView:nil];
                    [MXComUserDefault saveUserPassword:self.currentPwTf.text withAccount:[MXComUserDefault getUserAccount]];
                }
                    break;
                default:
                {
                    [MXProgressHUD showError:@"密码不正确" toView:nil];
                }
                    break;
            }
        } failure:^(NSError * _Nonnull error) {
            [MXProgressHUD showError:@"修改失败，请检查网络" toView:nil];
        }];
    }
}

@end
