//
//  MXPersonalBarButton.m
//  MXInteraction
//
//  Created by maRk on 16/8/25.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXPersonalBarButton.h"

@interface MXPersonalBarButton()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) void(^ActionBlock)(NSInteger);

@end

@implementation MXPersonalBarButton

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame index:(NSInteger)index title:(NSString *)title andActionBlock:(void(^)(NSInteger))block
{
    if (self == [super initWithFrame:frame]) {
        _ActionBlock = block;
        [self initUIWithIndex:index andTitle:title];
        [self initConstraint];
    }
    return self;
}

- (void)initUIWithIndex:(NSInteger)index andTitle:(NSString *)title
{
    self.tag = index;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_personal_bar%ld",(long)index]];
    self.imageView = imageView;
    [self addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor blackColor];
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tapGesture];
}

- (void)initConstraint
{
    MXWeakSelf;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(5);
        make.centerX.equalTo(weakSelf);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.imageView.mas_bottom).offset(2);
    }];
}

#pragma mark - 内部方法
- (void)tap
{
    _ActionBlock(self.tag);
}
@end
