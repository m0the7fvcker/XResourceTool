//
//  MXHomeKeyBagVC.m
//  MXInteraction
//
//  Created by maRk on 16/10/12.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHomeKeyBagVC.h"
#import "MXHomeHeaderMenuBtn.h"
#import "MXHomeClockView.h"

#import "MXUserKeyBagModel.h"

#define HomeKeyBagKeyWidth 80
#define HomeKeyBagBtnWidth_Later6 70
#define HomeKeyBagBtnWidth_Before6 60
#define HomeKeyBagBtnHeight HomeKeyBagBtnWidth
#define HomeKeyBagBtnLineMargin 30

@interface MXHomeKeyBagVC ()

@property (nonatomic, weak) UIImageView *bgView;
@property (nonatomic, weak) UIButton *bottomButton;
@property (nonatomic, weak) UILabel *timeView;
@property (nonatomic, weak) UIImageView *adView;

@end

@implementation MXHomeKeyBagVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI
{
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgView.image = [UIImage imageNamed:@"keyBag_bg"];
    self.bgView = bgView;
    [self.view addSubview:bgView];
    
    MXHomeClockView *clickView = [[MXHomeClockView alloc] initWithFrame:CGRectMake(30, 75, 140, 50) andDateString:[self getTime]];
    [self.view addSubview:clickView];
    
    UIImageView *adView = [[UIImageView alloc] initWithFrame:CGRectMake(MXScreen_Width - 35 - 100, 75, 100, 175)];
    adView.image =  [self getLocalAdImageFromLocal]? [self getLocalAdImageFromLocal] : [UIImage imageNamed:@"img_malfunction"];
    self.adView = adView;
    [self.view addSubview:adView];
    
    CGFloat keyWidth = 0;
    if (MXDevice_Is_iPhone4 || MXDevice_Is_iPhone5) {
        keyWidth = HomeKeyBagBtnWidth_Before6;
    }else {
        keyWidth = HomeKeyBagBtnWidth_Later6;
    }
    UIButton *bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(MXScreen_Width * 0.5 - keyWidth * 0.5, MXScreen_Height - 40 - keyWidth, keyWidth, keyWidth)];
    [bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomBtn setBackgroundImage:[UIImage imageNamed:@"home_btn_key"] forState:UIControlStateNormal];
    [self.view addSubview:bottomBtn];
    
    for (int i = 0 ; i < self.keyBagArray.count; i++) {
        CGFloat buttonW = 80;
        CGFloat marginX = (MXScreen_Width - 3 * buttonW) / 4;
        CGFloat bottomMargin = 220;
        CGFloat buttonH = buttonW;
        CGFloat buttonX = marginX + (marginX + buttonW) * (i % 3);
        CGFloat buttonY = MXScreen_Height -  (bottomMargin + (buttonW + HomeKeyBagBtnLineMargin) * (i / 3));
        NSString *title = [NSString stringWithFormat:@"%d号围机",i + 1];
        MXWeakSelf;
        MXHomeHeaderMenuBtn *keyButton = [[MXHomeHeaderMenuBtn alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH) index:i title:title image:@"keyBag_icon_key0" isKeybag:YES andActionBlock:^(NSInteger index) {
            [weakSelf didClickKeyAtIndex:index];
        }];
        [self.view addSubview:keyButton];
    }
    
}

- (void)didClickKeyAtIndex:(NSInteger)index
{
    MXUserKeyBagModel *key = self.keyBagArray[index];
    
    [[MXEMClientTool shareTool] sendOpenRequestCMDToPoint:key.imKey withRemoteSerial:key.name];
    [MXEMClientTool shareTool].keyBagVC = self;
    [MXEMClientTool shareTool].openHasResponse = NO;
    [MXEMClientTool shareTool].deviceState = MXDeviceState_Busy;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (![MXEMClientTool shareTool].openHasResponse ) {
            [MXProgressHUD showError:@"对方不在线" toView:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }
    });
}

- (void)bottomBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)close
{
    [self removeFromParentViewController];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)getLocalAdImageFromLocal
{
    NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    UIImage *adImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/keyBagAdImage",documentsDirectoryPath]];
    
    return adImage;
}

- (NSString *)getTime
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/YYYY"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    return dateString;
}
@end
