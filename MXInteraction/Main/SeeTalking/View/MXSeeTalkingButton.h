//
//  MXSeeTalkingButton.h
//  MXInteraction
//
//  Created by maRk on 16/10/11.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXSeeTalkingButton : UIImageView

- (instancetype)initWithFrame:(CGRect)frame withTag:(NSInteger)tag andAction:(void (^)(NSInteger))block;

@end
