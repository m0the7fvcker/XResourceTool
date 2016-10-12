//
//  MXHomeLeftMenuBtn.h
//  MXInteraction
//
//  Created by maRk on 16/10/12.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXHomeLeftMenuBtn : UIView

- (instancetype)initWithFrame:(CGRect)frame withTag:(NSInteger)tag image:(NSString *)image title:(NSString *)title andAction:(void(^)(NSInteger))action;

@end
