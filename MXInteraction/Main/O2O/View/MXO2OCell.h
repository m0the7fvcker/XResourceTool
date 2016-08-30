//
//  MXO2OCell.h
//  MXInteraction
//
//  Created by maRk on 16/8/25.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXO2OCommonModel.h"

@interface MXO2OCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightIcon;
@property (weak, nonatomic) IBOutlet UIImageView *centerImage;
@property (nonatomic, strong) MXO2OCommonModel *model;

@end
