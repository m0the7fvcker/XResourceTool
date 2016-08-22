//
//  MXCommunityControlVC.m
//  MXInteraction
//
//  Created by maRk on 16/8/19.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXCommunityControlVC.h"

@interface MXCommunityControlVC ()

@end

@implementation MXCommunityControlVC

#pragma mark - 控制器方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self setUpSubControllers];
    
    [self initUI];
    
}

#pragma mark - 初始化方法
- (void)initUI
{
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight) {
        
        // 设置标题字体
        *titleFont            = [UIFont systemFontOfSize:13];
        *norColor             = [UIColor mx_colorWithHexString:@"33333"];
        *selColor             = [UIColor mx_colorWithHexString:@"0085e1"];
        *titleScrollViewColor = [UIColor mx_colorWithHexString:@"eff3f4"];
    }];
    
    [self setUpUnderLineEffect:^(BOOL *isShowUnderLine, BOOL *isDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor) {
        
        // 是否显示标签
        *isShowUnderLine = YES;
        
        // 标题填充模式
        *underLineColor  = [UIColor mx_colorWithHexString:@"0085e1"];
    }];
    
    self.titleScrollViewColor = [UIColor mx_colorWithHexString:@"eff3f4"];
    self.titleHeight          = 40;
    self.isfullScreen         = NO;
}

@end
