//
//  MXPersonalBarButton.h
//  MXInteraction
//
//  Created by maRk on 16/8/25.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXPersonalBarButton : UIView

- (instancetype)initWithFrame:(CGRect)frame index:(NSInteger)index title:(NSString *)title andActionBlock:(void(^)(NSInteger))block;

@end
