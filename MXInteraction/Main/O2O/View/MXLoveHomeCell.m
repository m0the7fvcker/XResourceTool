//
//  MXLoveHomeCell.m
//  MXInteraction
//
//  Created by maRk on 16/8/27.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXLoveHomeCell.h"

@implementation MXLoveHomeCell

- (void)setModel:(MXO2OCommonModel *)model
{
    self.titleLabel.text = model.titleName;
    self.adView.image = [UIImage imageNamed:model.imageName];
}

@end
