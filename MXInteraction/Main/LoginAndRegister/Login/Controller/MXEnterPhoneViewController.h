//
//  MXEnterPhoneViewController.h
//  MXInteraction
//
//  Created by maRk'sTheme on 16/8/16.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXEnterPhoneViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *comfirmPhoneTF;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (nonatomic, assign) BOOL isResetPwd;

@end
