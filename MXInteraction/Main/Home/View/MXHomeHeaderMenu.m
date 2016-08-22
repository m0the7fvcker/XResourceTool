//
//  MXHomeHeaderView.m
//  MXInteraction
//
//  Created by maRk on 16/8/18.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHomeHeaderMenu.h"

@interface MXHomeHeaderMenu()

@property (nonatomic, strong) NSMutableArray <UIButton *> *btnArray;
@property (nonatomic, strong) NSArray <NSString *>*menuTitle;

@end

@implementation MXHomeHeaderMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self initData];
        [self initUI];
    }
    return self;
}

- (void)initData
{
    self.menuTitle = @[@"可视对讲",
                       @"开门记录",
                       @"授权管理",
                       @"免打扰",
                       @"社区互帮",
                       @"O2O商城",
                       @"智享体验",
                       @"分享开门"];
}

- (void)initUI
{
    for (int i = 0 ; i < 8; i++) {
        // 创建菜单按钮
        UIButton *menuBtn = [[UIButton alloc]init];
        [menuBtn addTarget:self action:@selector(menuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [menuBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"home_icon_%d",i]] forState:UIControlStateNormal];
        [menuBtn setTitle:self.menuTitle[i] forState:UIControlStateNormal];
        
        menuBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 0, 0);
        menuBtn.titleEdgeInsets = UIEdgeInsetsMake(40, -30, 10, 0);
//        menuBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        menuBtn.tag = i;
        menuBtn.backgroundColor = [UIColor mx_randomColor];
        [self addSubview:menuBtn];
        
        CGFloat btnWidth = MXScreen_Width / 4;
        CGFloat btnHeight = btnWidth;
        CGFloat btnX = btnWidth * (menuBtn.tag % 4);
        CGFloat btnY = btnHeight * (menuBtn.tag / 4);
        menuBtn.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
    }
}

- (void)menuButtonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(MXHomeHeaderMenuButtonDidClick:)]) {
        [self.delegate MXHomeHeaderMenuButtonDidClick:button.tag];
    }
}
@end
