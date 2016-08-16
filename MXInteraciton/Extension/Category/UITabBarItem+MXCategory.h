//
//  UITabBarItem+MXCategory.h
//  MXInteraction
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarItem (MXCategory)
- (void)setTitle:(NSString *)title norImgName:(NSString *)imgName selImgName:(NSString *)selImgName;

- (void)setTitle:(NSString *)title norImg:(UIImage *)norImg selImg:(UIImage *)selImg;
@end
