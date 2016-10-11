//
//  MXSeeTalkingVC.m
//  MXInteraction
//
//  Created by maRk on 16/10/11.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXSeeTalkingVC.h"
#import "MXSeeTalkingButton.h"

#import "MXUserKeyBagModel.h"

#define SeeTalkingButtonMargin 13
#define SeeTalkingHeaderHeight 40

@interface MXSeeTalkingVC ()

@property (nonatomic, weak) UILabel *headerLabel;

@end

@implementation MXSeeTalkingVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MXScreen_Width, SeeTalkingHeaderHeight)];
    headerLabel.text = @"  选择大门查看监视";
    headerLabel.backgroundColor = [UIColor mx_colorWithHexString:@"ececec"];
    self.headerLabel = headerLabel;
    [self.view addSubview:headerLabel];
    
    for (int i = 0 ; i < self.keyBagArray.count; i++) {
        CGFloat BtnW = (MXScreen_Width - SeeTalkingButtonMargin * 4)/3;
        CGFloat BtnH = BtnW;
        CGFloat BtnX = (BtnW + SeeTalkingButtonMargin) * (i % 3) + SeeTalkingButtonMargin;
        CGFloat BtnY = (BtnH + SeeTalkingButtonMargin) * (i / 3) + SeeTalkingButtonMargin + SeeTalkingHeaderHeight;
        
        MXWeakSelf;
        MXSeeTalkingButton *button = [[MXSeeTalkingButton alloc] initWithFrame:CGRectMake(BtnX, BtnY, BtnW, BtnH) withTag:i andAction:^(NSInteger index) {
            [weakSelf didClickMonitorButton:index];
        }];
        [self.view addSubview:button];
    }
}

- (void)didClickMonitorButton:(NSInteger)index
{
    NSLog(@"%ld",index);
    MXUserKeyBagModel *model = self.keyBagArray[index];
    
//    [[MXEMClientTool shareTool] sendCallTo:@"maxiao1"];
    [[MXEMClientTool shareTool] sendCMD:@"11" to:model.imKey];
}

@end
