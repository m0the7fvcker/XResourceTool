//
//  MXHomeKeyBagVC.h
//  MXInteraction
//
//  Created by maRk on 16/10/12.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXBaseViewController.h"
@class MXUserKeyBagModel;

@interface MXHomeKeyBagVC : MXBaseViewController

@property (nonatomic, strong) NSArray <MXUserKeyBagModel *>*keyBagArray;
- (void)close;
@end
