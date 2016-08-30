//
//  MXCommunityMarketCell.h
//  MXInteraction
//
//  Created by maRk on 16/8/25.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXCommunityMarketModel.h"

@interface MXCommunityMarketCell : UITableViewCell

@property (nonatomic, strong) MXCommunityMarketModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UIImageView *uploadImage;

@end
