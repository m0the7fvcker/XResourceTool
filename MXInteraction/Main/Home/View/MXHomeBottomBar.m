//
//  MXHomeBottomBar.m
//  MXInteraction
//
//  Created by maRk on 16/8/19.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHomeBottomBar.h"

@interface MXHomeBottomBar()

/** 保存Block */
@property (nonatomic, strong) void(^actionBlock)();
/** 底部背景图片 */
@property (nonatomic, weak) UIImageView *backgroundView;
/** 钥匙按钮 */
@property (nonatomic, weak) UIButton *keyButton;

@end

@implementation MXHomeBottomBar

- (instancetype)initWithFrame:(CGRect)frame andClickBlock:(void(^)())block
{
    if (self = [super initWithFrame:frame]) {
        [self initUIAndActionblock:block];
        [self initConstraint];
    }
    return self;
}

- (void)initUIAndActionblock:(void(^)())block
{
    _actionBlock = block;
    
    UIImageView *backgroundView = [[UIImageView alloc] init];
    backgroundView.image = [UIImage imageNamed:@"tabbar_bg"];
    self.backgroundView = backgroundView;
    [self addSubview:backgroundView];
    
    UIButton *keyButton = [[UIButton alloc] init];
    [keyButton setBackgroundImage:[UIImage imageNamed:@"btn_card"] forState:UIControlStateNormal];
    [keyButton addTarget:self action:@selector(keyButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.keyButton = keyButton;
    [self addSubview:keyButton];
}

- (void)initConstraint
{
    MXWeakSelf;
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(weakSelf);
    }];
    
    [self.keyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(weakSelf);
        make.width.height.equalTo(@(weakSelf.height - 10));
    }];
}

- (void)keyButtonClick
{
    _actionBlock();
}
@end
