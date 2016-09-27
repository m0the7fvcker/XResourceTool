//
//  MXHomeServiceBtn.m
//  MXInteraction
//
//  Created by maRk on 16/8/23.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXHomeServiceBtn.h"

@interface MXHomeServiceBtn()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end

@implementation MXHomeServiceBtn

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame index:(NSInteger)index title:(NSString *)title subTitle:(NSString *)subTitle
{
    if (self == [super initWithFrame:frame]) {
        [self initUIWithIndex:index title:title andSubTitle:subTitle];
        [self initConstraint];
    }
    return self;
}

- (void)initUIWithIndex:(NSInteger)index title:(NSString *)title andSubTitle:(NSString *)subTitle
{
    self.tag = index;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"home_icon_%ld",(long)index]];
    self.imageView = imageView;
    [self addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor mx_colorWithHexString:@"0e0d0c"];
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    
    UILabel *subTitleLabel = [[UILabel alloc] init];
    subTitleLabel.font = [UIFont systemFontOfSize:13];
    subTitleLabel.text = subTitle;
    subTitleLabel.textColor = [UIColor mx_colorWithHexString:@"72706f"];
    self.subTitleLabel = subTitleLabel;
    [self addSubview:subTitleLabel];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tapGesture];
}

- (void)initConstraint
{
    MXWeakSelf;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
        make.left.equalTo(weakSelf).offset(15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf).offset(-10);
        make.width.equalTo(@200);
        make.left.equalTo(weakSelf.imageView.mas_right).offset(25);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf).offset(10);
        make.width.equalTo(@200);
        make.left.equalTo(weakSelf.imageView.mas_right).offset(5);
    }];
}

#pragma mark - 内部方法
- (void)tap
{
    if (self.tag == 0) {
        [MXNotificationCenterAccessor postNotificationName:MXNoti_Home_HouseSrv object:nil];
    }
    
    if (self.tag == 1) {
        [MXNotificationCenterAccessor postNotificationName:MXNoti_Home_ElevatorSrv object:nil];
    }
}

@end
