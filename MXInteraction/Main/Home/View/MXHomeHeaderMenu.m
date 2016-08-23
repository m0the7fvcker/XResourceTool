//
//  MXHomeHeaderView.m
//  MXInteraction
//
//  Created by maRk on 16/8/18.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHomeHeaderMenu.h"
#import "MXHomeHeaderMenuBtn.h"

@interface MXHomeHeaderMenu()

@property (nonatomic, strong) NSMutableArray <UIButton *> *btnArray;
@property (nonatomic, strong) NSArray <NSString *>*menuTitle;

@end

@implementation MXHomeHeaderMenu

#pragma mark - 初始化方法
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
        CGFloat btnWidth = MXScreen_Width / 4;
        CGFloat btnHeight = btnWidth;
        CGFloat btnX = btnWidth * (i % 4);
        CGFloat btnY = btnHeight * (i / 4);
        CGRect frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
        
        MXWeakSelf;
        MXHomeHeaderMenuBtn *menuBtn = [[MXHomeHeaderMenuBtn alloc] initWithFrame:frame index:i title:self.menuTitle[i] andActionBlock:^(NSInteger index) {
            [weakSelf menuButtonClick:index];
        }];
        [self addSubview:menuBtn];
    }
}

#pragma mark - 内部方法
- (void)menuButtonClick:(NSInteger )index
{
    if ([self.delegate respondsToSelector:@selector(MXHomeHeaderMenuButtonDidClick:)]) {
        [self.delegate MXHomeHeaderMenuButtonDidClick:index];
    }
}
@end
