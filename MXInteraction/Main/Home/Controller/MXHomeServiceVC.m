//
//  MXHomeServiceVC.m
//  MXInteraction
//
//  Created by maRk on 16/8/31.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHomeServiceVC.h"

@interface MXHomeServiceVC ()

@end

@implementation MXHomeServiceVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor mx_colorWithHexString:@"f1f0f0"];
    
    self.descriptionView.layer.cornerRadius = 5;
    self.descriptionView.layer.borderWidth = 0.5;
    self.descriptionView.layer.borderColor = [UIColor mx_colorWithHexString:@"d2d2d2"].CGColor;
    
    self.cameraButton.layer.cornerRadius = 5;
    self.cameraButton.layer.borderWidth = 0.5;
    self.cameraButton.layer.borderColor = [UIColor mx_colorWithHexString:@"d2d2d2"].CGColor;
    
    self.phoneNumberField.layer.cornerRadius = 5;
    self.phoneNumberField.layer.borderWidth = 0.5;
    self.phoneNumberField.layer.borderColor = [UIColor mx_colorWithHexString:@"d2d2d2"].CGColor;
    
    self.submitButton.layer.cornerRadius = 5;
}

- (IBAction)submitClick:(UIButton *)sender
{
    if (self.descriptionView.text.length == 0) {
        [MXProgressHUD showError:@"故障描述不能为空" toView:nil];
    }else {
        [MXProgressHUD showSuccess:@"提交成功" toView:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
