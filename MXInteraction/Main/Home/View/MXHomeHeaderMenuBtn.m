//
//  MXHomeHeaderMenuBtn.m
//  MXInteraction
//
//  Created by maRk on 16/8/22.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHomeHeaderMenuBtn.h"

@interface MXHomeHeaderMenuBtn()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) void(^ActionBlock)(NSInteger);
@end

@implementation MXHomeHeaderMenuBtn

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame index:(NSInteger)index title:(NSString *)title image:(NSString *)image andActionBlock :(void (^)(NSInteger))block
{
    if (self == [super initWithFrame:frame]) {
        _ActionBlock = block;
        [self initUIWithIndex:index title:title andImage:image];
        [self initConstraint];
    }
    return self;
}

- (void)initUIWithIndex:(NSInteger)index title:(NSString *)title andImage:(NSString *)image
{
    self.tag = index;
    
    UIView *containerView = [[UIView alloc] init];
    self.containerView = containerView;
    [self addSubview:containerView];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:image];
    self.imageView = imageView;
    [self.containerView addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor blackColor];
    [titleLabel sizeToFit];
    self.titleLabel = titleLabel;
    [self.containerView addSubview:titleLabel];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tapGesture];
}

- (void)initConstraint
{
    MXWeakSelf;
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
        make.width.equalTo(@50);
        make.height.equalTo(@70);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.containerView);
        make.height.equalTo(@50);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.containerView);
        make.top.equalTo(weakSelf.imageView.mas_bottom).offset(5);
    }];
}

#pragma mark - 内部方法
- (void)tap
{
    _ActionBlock(self.tag);
}
@end