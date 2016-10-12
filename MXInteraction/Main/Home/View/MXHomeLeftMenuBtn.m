//
//  MXHomeLeftMenuBtn.m
//  MXInteraction
//
//  Created by maRk on 16/10/12.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHomeLeftMenuBtn.h"

@interface MXHomeLeftMenuBtn()

@property (nonatomic, copy) void(^Action)(NSInteger);
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *indicatorView;

@end

@implementation MXHomeLeftMenuBtn

- (instancetype)initWithFrame:(CGRect)frame withTag:(NSInteger)tag image:(NSString *)image title:(NSString *)title andAction:(void(^)(NSInteger))action
{
    if (self = [super initWithFrame:frame]) {
        self.tag = tag;
        self.Action = action;
        self.image = image;
        self.title = title;
        [self initUI];
        [self initConstraint];
    }
    return self;
}

- (void)initUI
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tap];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:self.image];
    self.imageView = imageView;
    [self addSubview:imageView];
    
    CGFloat fontSize = 0;
    if (MXDevice_Is_iPhone5 || MXDevice_Is_iPhone4) {
        fontSize = 14;
    }else {
        fontSize = 18;
    }
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = self.title;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:fontSize];
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    
    UIImageView *indicatorView = [[UIImageView alloc] init];
    indicatorView.image = [UIImage imageNamed:@"icon_sidebar_indicator"];
    self.indicatorView = indicatorView;
    [self addSubview:indicatorView];
}

- (void)initConstraint
{
    MXWeakSelf;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@28);
        make.left.equalTo(weakSelf.mas_left).offset(25);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@200);
        make.left.equalTo(weakSelf.imageView.mas_right).offset(15);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@23);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
}

- (void)tap
{
    self.backgroundColor = [UIColor mx_colorWithHexString:@"7B7661"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.backgroundColor = [UIColor clearColor];
    });
    
    self.Action(self.tag);
}

@end
