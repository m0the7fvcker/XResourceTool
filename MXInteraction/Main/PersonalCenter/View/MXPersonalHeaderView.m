//
//  MXPersonalHeaderView.m
//  MXInteraction
//
//  Created by maRk on 16/8/24.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXPersonalHeaderView.h"

@interface MXPersonalHeaderView()

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *phoneLabel;

@end

@implementation MXPersonalHeaderView

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self initUI];
        [self initConstraint];
    }
    return self;
}

- (void)initUI
{
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.image = [UIImage imageNamed:@"icon_personal_user"];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    phoneLabel.textColor = [UIColor whiteColor];
    phoneLabel.text = @"13814383838";
    [self addSubview:phoneLabel];
    self.phoneLabel = phoneLabel;
}

- (void)initConstraint
{
    MXWeakSelf;
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@70);
        make.top.equalTo(weakSelf).offset(60);
        make.centerX.equalTo(weakSelf);
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iconView.mas_bottom).offset(15);
        make.centerX.equalTo(weakSelf);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
    }];
}
@end
