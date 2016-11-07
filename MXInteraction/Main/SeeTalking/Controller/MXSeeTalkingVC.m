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
    headerLabel.font = [UIFont systemFontOfSize:15];
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
    MXUserKeyBagModel *key = self.keyBagArray[index];
    
    MXIncomingVC *incomingVC = [[MXIncomingVC alloc] initWithIsCaller:YES andKeyName:key.name];
    incomingVC.remoteIMKey = key.imKey;
    incomingVC.remoteSerial = key.name;
    
    // 修改状态为响铃状态
    [MXEMClientTool shareTool].incomingVC = incomingVC;
    [MXEMClientTool shareTool].deviceState = MXDeviceState_Busy;
    [MXEMClientTool shareTool].monitorHasResponse = NO;
    [[MXEMClientTool shareTool] sendMonitorRequestCMDToPoint:key.imKey withRemoteSerial:key.name];
    [MXApplicationAccessor.keyWindow.rootViewController presentViewController:incomingVC animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 对方有回应且呼叫界面还未关闭时弹出提示
        if (![MXEMClientTool shareTool].monitorHasResponse && [MXEMClientTool shareTool].incomingVC) {
            [MXProgressHUD showError:@"对方不在线" toView:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[MXEMClientTool shareTool].incomingVC close];
            });
        }
    });
}

@end
