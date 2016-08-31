//
//  MXCommunityMarketCell.m
//  MXInteraction
//
//  Created by maRk on 16/8/25.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXCommunityMarketCell.h"

@implementation MXCommunityMarketCell

- (void)awakeFromNib
{
    self.uploadImage.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)setModel:(MXCommunityMarketModel *)model
{
    self.iconImage.image = [UIImage imageNamed:model.iconName];
    self.nameLabel.text = model.nickName;
    self.desLabel.text = model.desString;
    self.uploadImage.image = [UIImage imageNamed:model.imageName];
}

@end
