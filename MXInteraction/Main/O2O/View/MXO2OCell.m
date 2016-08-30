//
//  MXO2OCell.m
//  MXInteraction
//
//  Created by maRk on 16/8/25.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXO2OCell.h"

@implementation MXO2OCell

- (void)setModel:(MXO2OCommonModel *)model
{
    self.leftIcon.image = [UIImage imageNamed:model.iconName];
    self.nameLabel.text = model.titleName;
    self.centerImage.image = [UIImage imageNamed:model.imageName];
}

@end
