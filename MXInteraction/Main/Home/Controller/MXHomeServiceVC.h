//
//  MXHomeServiceVC.h
//  MXInteraction
//
//  Created by maRk on 16/8/31.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXBaseViewController.h"

@interface MXHomeServiceVC : MXBaseViewController
@property (weak, nonatomic) IBOutlet UITextView *descriptionView;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;

@end
