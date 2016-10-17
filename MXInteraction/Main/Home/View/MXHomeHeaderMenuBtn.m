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
@property (nonatomic, assign) BOOL isKeyBag;
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

- (instancetype)initWithFrame:(CGRect)frame index:(NSInteger)index title:(NSString *)title image:(NSString *)image isKeybag:(BOOL)isKeyBag andActionBlock:(void(^)(NSInteger))block
{
    self.isKeyBag = isKeyBag;
    return [self initWithFrame:frame index:index title:title image:image andActionBlock:block];
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
    
    CGFloat fontSize = 0;
    if (MXDevice_Is_iPhone5 || MXDevice_Is_iPhone4) {
        fontSize = 12;
    }else {
        fontSize = 13;
    }
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:fontSize];
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
    CGFloat buttonWdith = 0;
    if (MXDevice_Is_iPhone4 || MXDevice_Is_iPhone5) {
        buttonWdith = 40;
    }else {
        buttonWdith = 45;
    }
    if (self.isKeyBag) buttonWdith = 60;
    MXWeakSelf;
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(9);
        make.center.equalTo(weakSelf);
        make.width.equalTo(@(buttonWdith));
        make.height.equalTo(@70);
    }];
    
    CGFloat offset = 0;
    if (MXDevice_Is_iPhone4 || MXDevice_Is_iPhone5) {
        offset = 5;
    }else {
        offset = 9;
    }
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.containerView);
        make.top.equalTo(weakSelf.containerView.mas_top).offset(offset);
        make.height.equalTo(@(buttonWdith));
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
