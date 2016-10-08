//
//  MXForgetPdAndRegisterVC.h
//  MXInteraction
//
//  Created by maRk'sTheme on 16/8/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXForgetPdAndRegisterVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, assign) BOOL isResetPwd;

@end
