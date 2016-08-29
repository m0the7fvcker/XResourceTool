//
//  MXHomeHeaderMenuBtn.h
//  MXInteraction
//
//  Created by maRk on 16/8/22.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXHomeHeaderMenuBtn : UIView

- (instancetype)initWithFrame:(CGRect)frame index:(NSInteger)index title:(NSString *)title image:(NSString *)image andActionBlock:(void(^)(NSInteger))block;

@end
