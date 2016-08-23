//
//  UIBarButtonItem+MXCategory.m
//  MXInteraction
//
//  Created by maRk on 16/8/22.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "UIBarButtonItem+MXCategory.h"

@implementation UIBarButtonItem (MXCategory)

+ (UIBarButtonItem *)mx_itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (highImageName) {
        [button setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    }
    
    // 设置按钮的尺寸为背景图片的尺寸
    button.frame     = (CGRect){0,0,button.currentBackgroundImage.size};
    
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
