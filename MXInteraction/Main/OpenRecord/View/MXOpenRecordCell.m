//
//  MXOpenRecordCell.m
//  MXInteraction
//
//  Created by maRk on 16/9/27.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXOpenRecordCell.h"

@interface MXOpenRecordCell ()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *recordLabel;

@end

@implementation MXOpenRecordCell

#pragma mark - 初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        [self initConstraint];
    }
    return self;
}

- (void)initUI
{
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.text = @"今天\n10:55";
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.textColor = [UIColor mx_colorWithHexString:@"a5a5a5"];
    timeLabel.numberOfLines = 0;
    self.timeLabel = timeLabel;
    [self.contentView addSubview:timeLabel];
    
    UILabel *recordLabel = [[UILabel alloc] init];
    recordLabel.text = @"App开门";
    recordLabel.font = [UIFont systemFontOfSize:14];
    recordLabel.textColor = [UIColor mx_colorWithHexString:@"fc444c"];
    [recordLabel sizeToFit];
    self.recordLabel = recordLabel;
    [self.contentView addSubview:recordLabel];
}

- (void)initConstraint
{
    MXWeakSelf;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.contentView.mas_left).offset(22.5);
    }];
    
    [self.recordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(weakSelf.contentView);
    }];
}

- (void)setModel:(MXOpenRecordModel *)model
{
    self.timeLabel.text = model.time;
    self.recordLabel.text = model.result;
}
@end
