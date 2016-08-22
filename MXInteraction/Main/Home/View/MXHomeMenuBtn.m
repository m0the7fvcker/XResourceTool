//
//  MXHomeMenuBtn.m
//  MXInteraction
//
//  Created by maRk on 16/8/22.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHomeMenuBtn.h"

@interface MXHomeMenuBtn()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) void(^ActionBlock)(NSInteger);
@end

@implementation MXHomeMenuBtn

- (instancetype)initWithFrame:(CGRect)frame andActionBlock:(void(^)(NSInteger))block
{
    if (self == [super initWithFrame:frame]) {
        _ActionBlock = block;
        [self initUI];
        [self initConstraint];
    }
    return self;
}

- (void)initUI
{
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    [self addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
}

- (void)initConstraint
{
    MXWeakSelf;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
        make.width.equalTo(@34);
        make.height.equalTo(@34);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.imageView.mas_bottom).offset(5);
    }];
}
@end
