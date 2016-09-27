//
//  MXOpenRecordSectionHeader.m
//  MXInteraction
//
//  Created by maRk on 16/9/27.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXOpenRecordSectionHeader.h"

@interface MXOpenRecordSectionHeader()

@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation MXOpenRecordSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initUI];
        [self initConstraint];
    }
    return  self;
}

- (void)initUI
{
    self.backgroundColor = [UIColor mx_colorWithHexString:@"ececec"];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.textColor = [UIColor mx_colorWithHexString:@"0e0d0c"];
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
}

- (void)initConstraint
{
    MXWeakSelf;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left).offset(21.5);
        make.top.bottom.equalTo(weakSelf.contentView);
    }];
}

- (void)setTitle:(NSString *)title
{
    self.timeLabel.text = title;
}
@end
