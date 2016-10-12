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
/** 钥匙包文字 */
@property (nonatomic, weak) UILabel *keyLabel;

@end

@implementation MXHomeBottomBar

#pragma mark - 初始化方法
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
    backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    backgroundView.image = [UIImage imageNamed:@"home_tabbar_bg"];
    self.backgroundView = backgroundView;
    [self addSubview:backgroundView];
    
    UIButton *keyButton = [[UIButton alloc] init];
    [keyButton setBackgroundImage:[UIImage imageNamed:@"home_btn_key"] forState:UIControlStateNormal];
    [keyButton addTarget:self action:@selector(keyButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.keyButton = keyButton;
    [self addSubview:keyButton];
    
    CGFloat fontSize = 0;
    if (MXDevice_Is_iPhone5 || MXDevice_Is_iPhone4) {
        fontSize = 10;
    }else {
        fontSize = 13;
    }
    UILabel *keyLabel = [[UILabel alloc] init];
    keyLabel.font = [UIFont systemFontOfSize:fontSize];
    keyLabel.textAlignment = NSTextAlignmentCenter;
    keyLabel.text = @"钥匙包";
    self.keyLabel = keyLabel;
    [self addSubview:keyLabel];
}

- (void)initConstraint
{
    MXWeakSelf;
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(weakSelf);
    }];
    
    [self.keyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.width.height.equalTo(@(weakSelf.height - 15));
        make.bottom.equalTo(weakSelf.mas_bottom).offset(- 15);
    }];
    
    [self.keyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.keyButton);
        make.width.equalTo(@100);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(- 3);
    }];
}

#pragma mark - 内部方法
- (void)keyButtonClick
{
    _actionBlock();
}
@end
