//
//  MXHomeKeyBagVC.m
//  MXInteraction
//
//  Created by maRk on 16/10/12.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHomeKeyBagVC.h"
#import "MXHomeHeaderMenuBtn.h"

#define HomeKeyBagBtnWidth 80
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
    
    UILabel *timeView = [[UILabel alloc] initWithFrame:CGRectMake(30, 75, 100, 50)];
    timeView.text = @"2016:10:12";
    self.timeView = timeView;
    [self.view addSubview:timeView];
    
    UIImageView *adView = [[UIImageView alloc] initWithFrame:CGRectMake(MXScreen_Width - 35 - 210, 75, 210, 175)];
    adView.image = [UIImage imageNamed:@"img_malfunction"];
    self.adView = adView;
    [self.view addSubview:adView];
    
    UIButton *bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(MXScreen_Width * 0.5 - HomeKeyBagBtnWidth * 0.5, MXScreen_Height - 40 - HomeKeyBagBtnWidth, HomeKeyBagBtnWidth, HomeKeyBagBtnHeight)];
    [bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomBtn setBackgroundImage:[UIImage imageNamed:@"home_btn_key"] forState:UIControlStateNormal];
    [self.view addSubview:bottomBtn];
    
    for (int i = 0 ; i < self.keyBagArray.count; i++) {
        CGFloat marginX = (MXScreen_Width - 3 * HomeKeyBagBtnWidth) / 4;
        CGFloat bottomMargin = 220;
        CGFloat buttonW = 80;
        CGFloat buttonH = buttonW;
        CGFloat buttonX = marginX + (marginX + buttonW) * (i % 3);
        CGFloat buttonY = MXScreen_Height -  (bottomMargin + (buttonW + HomeKeyBagBtnLineMargin) * (i / 3));
        NSString *title = [NSString stringWithFormat:@"%d号围机",i + 1];
        MXWeakSelf;
        MXHomeHeaderMenuBtn *keyButton = [[MXHomeHeaderMenuBtn alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH) index:i title:title image:@"keyBag_icon_key0" andActionBlock:^(NSInteger index) {
            [weakSelf didClickKeyAtIndex:index];
        }];
        [self.view addSubview:keyButton];
    }
    
}

- (void)didClickKeyAtIndex:(NSInteger)index
{
    [MXProgressHUD showSuccess:@"开门成功" toView:self.view];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)bottomBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
