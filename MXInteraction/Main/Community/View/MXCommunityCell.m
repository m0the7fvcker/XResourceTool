//
//  MXCommunityCell.m
//  MXInteraction
//
//  Created by maRk on 16/8/25.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXCommunityCell.h"

@implementation MXCommunityCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setModel:(MXCommunityModel *)model
{
    self.iconImage.image = [UIImage imageNamed:model.iconName];
    self.nameLabel.text = model.nickName;
    self.timeLabel.text = model.timeString;
    self.desLabel.text = model.desString;
    self.uploadImage.image = [UIImage imageNamed:model.imageName];
}
@end
