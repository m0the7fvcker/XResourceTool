//
//  UITabBarItem+MXCategory.m
//  MXInteraciton
//
//  Created by maRk on 16/8/15.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "UITabBarItem+MXCategory.h"

@implementation UITabBarItem (MXCategory)

-(void)setTitle:(NSString *)title norImgName:(NSString *)imgName selImgName:(NSString *)selImgName{
    self.title = title;
    self.image = [UIImage imageNamed:imgName];
    self.selectedImage = [UIImage imageNamed:selImgName];
}

- (void)setTitle:(NSString *)title norImg:(UIImage *)norImg selImg:(UIImage *)selImg{
    self.title = title;
    self.image = norImg;
    self.selectedImage = selImg;
}
@end
