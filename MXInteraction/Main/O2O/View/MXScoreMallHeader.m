//
//  MXScoreMallHeader.m
//  MXInteraction
//
//  Created by maRk on 16/8/29.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXScoreMallHeader.h"

@interface MXScoreMallHeader()
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *myScoreLabel;
@property (nonatomic, weak) UILabel *showScoreLabel;
@property (nonatomic, weak) UILabel *countLabel;
@end
@implementation MXScoreMallHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
        [self initConstraint];
    }
    return self;
}

- (void)initUI
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image  = [UIImage imageNamed:@"banner1.png"];
    self.imageView = imageView;
    [self addSubview:imageView];
    
    UILabel *myScoreLabel = [[UILabel alloc] init];
    myScoreLabel.text = @"我的积分";
    self.myScoreLabel = myScoreLabel;
    [self addSubview:myScoreLabel];
    
    UILabel *showScoreLabel = [[UILabel alloc] init];
    showScoreLabel.textAlignment = NSTextAlignmentCenter;
    showScoreLabel.text = @"1231";
    showScoreLabel.textColor = [UIColor redColor];
    self.showScoreLabel = showScoreLabel;
    [self addSubview:showScoreLabel];
    
    UILabel *countLabel = [[UILabel alloc] init];
    countLabel.textAlignment = NSTextAlignmentRight;
    countLabel.text = @"兑换记录";
    self.countLabel = countLabel;
    [self addSubview:countLabel];
}

- (void)initConstraint
{
    MXWeakSelf;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf);
        make.height.equalTo(@200);
    }];
    
    [self.myScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imageView.mas_bottom);
        make.left.bottom.equalTo(weakSelf).offset(10);
        make.width.equalTo(@150);
    }];
    
    [self.showScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imageView.mas_bottom);
        make.centerX.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
        make.width.equalTo(@150);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imageView.mas_bottom);
        make.right.bottom.equalTo(weakSelf).offset(-10);
        make.width.equalTo(@150);
    }];
}

@end
