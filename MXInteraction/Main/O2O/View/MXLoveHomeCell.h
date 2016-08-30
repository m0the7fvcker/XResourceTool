//
//  MXLoveHomeCell.h
//  MXInteraction
//
//  Created by maRk on 16/8/27.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXO2OCommonModel.h"

@interface MXLoveHomeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *adView;
@property (nonatomic, strong) MXO2OCommonModel *model;

@end
